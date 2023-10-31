resource "volterra_virtual_k8s" "cluster" {
    name      = format("%s-zug1", var.project_prefix)

    vsite_refs {
      name      = format("%s-zug1", var.project_prefix)
      namespace = "shared"
    }
    namespace = volterra_namespace.myns.name
}

resource "volterra_api_credential" "cluster" {
  name      = format("%s-zug1", var.project_prefix)
  api_credential_type = "KUBE_CONFIG"
  virtual_k8s_namespace = volterra_namespace.myns.name
  virtual_k8s_name = volterra_virtual_k8s.cluster.name
}

resource "local_file" "kubeconfig" {
  content  = base64decode(volterra_api_credential.cluster.data)
  filename = "./kubeconfig"
}

