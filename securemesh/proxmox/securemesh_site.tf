resource "restapi_object" "securemesh_site" {
  id_attribute = "metadata/name"
  path         = "/config/namespaces/system/securemesh_sites"
  data         = jsonencode(
    {
      "metadata": {
        "name": var.f5xc_cluster_name,
        "namespace": "system",
        "labels": {
          "ves.io/siteName": "mw-zug1"
        },
        "annotations": {},
        "disable": false
      },
      "spec": {
        "volterra_certified_hw": "kvm-regular-nic-voltmesh",
        "master_node_configuration": [ 
        for k,v in proxmox_vm_qemu.master : { "name": "m${k}" }
      ],
        "worker_nodes": [ 
        for k,v in proxmox_vm_qemu.worker : { "name": "w${k}" }
      ],
        "no_bond_devices": {},
        "custom_network_config": {
          "default_config": {},
          "default_sli_config": {},
          "interface_list": {
            "interfaces": [
              {
                "description": "eth0",
                "labels": {},
                "ethernet_interface": {
                  "device": "eth0",
                  "cluster": {},
                  "untagged": {},
                  "dhcp_client": {},
                  "site_local_network": {},
                  "mtu": 0,
                  "priority": 0,
                  "not_primary": {},
                  "monitor_disabled": {}
                },
                "dc_cluster_group_connectivity_interface_disabled": {}
              },
              {
                "description": "eth1",
                "labels": {},
                "ethernet_interface": {
                  "device": "eth1",
                  "cluster": {},
                  "untagged": {},
                  "dhcp_client": {},
                  "site_local_inside_network": {},
                  "mtu": 0,
                  "priority": 0,
                  "not_primary": {},
                  "monitor_disabled": {}
                },
                "dc_cluster_group_connectivity_interface_disabled": {}
              }
            ]
          },
          "no_network_policy": {},
          "no_forward_proxy": {},
          "global_network_list": {
            "global_network_connections": [
              for vn in var.global_virtual_networks :
              {
                "sli_to_global_dr": {
                  "global_vn": {
                    "namespace": "system",
                    "name": "${vn}",
                    "kind": "virtual_network"
                  }
                }
              }
            ]
          },
          "vip_vrrp_mode": "VIP_VRRP_INVALID",
          "tunnel_dead_timeout": 0,
          "sm_connection_pvt_ip": {}
        },
        "coordinates": {
          "latitude": 8,
          "longitude": 4
        },
        "logs_streaming_disabled": {},
        "site_state": "WAITING_FOR_REGISTRATION",
        "default_blocked_services": {},
        "offline_survivability_mode": {
          "no_offline_survivability_mode": {}
        },
        "performance_enhancement_mode": {
          "perf_mode_l7_enhanced": {}
        }
      }
    }
  )
}
