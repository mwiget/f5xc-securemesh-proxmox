#cloud-config
users:
  - name: "vesop"
    passwd: ""
    groups:
      - "sudo"

coreos:
  update:
    reboot-strategy: "off"

network:
  version: 2

write_files:
  - path: /etc/vpm/config.yaml
    permissions: 0644
    owner: root
    content: |
      Kubernetes:
        EtcdUseTLS: true
        Server: vip
      Vpm:
        ClusterName: ${cluster-name}
        ClusterType: ce
        Config: /etc/vpm/config.yaml
        Hostname: ${host-name}
        Latitude: ${latitude}
        Longitude: ${longitude}
        MauriceEndpoint: ${maurice-endpoint}
        MauricePrivateEndpoint: ${maurice-private-endpoint}
        Proxy: {}
        Token: ${site-registration-token}

  - path: /etc/vpm/certified-hardware.yaml
    permissions: 0644
    owner: root
    content: |
      active: ${certifiedhardware}
      certifiedHardware:
        kvm-regular-nic-voltmesh:
          Vpm:
            PrivateNIC: eth0
          outsideNic:
          - eth0
        kvm-voltstack-combo:
          Vpm:
            PrivateNIC: eth0
          outsideNic:
          - eth0
      primaryOutsideNic: eth0

runcmd:
  - [ sh, -c, test -e /usr/bin/fsextend  && /usr/bin/fsextend || true ]

hostname: ${host-name}
fqdn: ${host-name}
