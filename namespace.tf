resource "volterra_namespace" "myns" {
  name = format("%s-zug1", var.project_prefix)
}

