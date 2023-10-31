# f5xc-securemesh-proxmox

Deploy F5 Distributed Cloud secure mesh site on proxmox single node or 3-node cluster.
It also creates a virtual site and vk8s cluster with just the one new proxmox site in it.


```
git clone --recurse-submodules https://github.com/mwiget/f5xc-securemesh-proxmox
```

```
cp terraform.tfvars.example terraform.tfvars
```

Add your proxmox and F5 XC credentials to terraform.tfvars

Deploy with

```
$ terraform init
$ terraform plan
$ terraform apply
```

A `kubeconfig` file will be created automatically in the current folder, which can be used to Deploy
pods on the vk8s (with one securemesh site in it):

```
$ source env.sh
$ kubectl cluster-info
Kubernetes control plane is running at https://volterra-corp.staging.volterra.us/api/vk8s/namespaces/mw-zug1/mw-zug1

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
```


