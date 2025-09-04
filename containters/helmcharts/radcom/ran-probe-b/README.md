# ran-probe-b

![Version: 14.01.04](https://img.shields.io/badge/Version-14.01.04-informational?style=flat-square) ![AppVersion: 1.0](https://img.shields.io/badge/AppVersion-1.0-informational?style=flat-square)

ran-probe-b

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cs-ran.ran-core-ms-chart.cdrPVC.storageSize | string | `"2Gi"` |  |
| cs-ran.ran-core-ms-chart.configMap.clusterName | string | `"RAN"` |  |
| cs-ran.ran-core-ms-chart.configMap.machineType | string | `"RAN-probe-b"` |  |
| cs-ran.ran-core-ms-chart.configMap.name | string | `"ranProbe-b"` |  |
| cs-ran.ran-core-ms-chart.configMap.networkIpMode | string | `"ipv4"` |  |
| cs-ran.ran-core-ms-chart.configMap.packetInternalInterfacePref | string | `"AWS_RADCOM_PACKET_INTERNAL"` |  |
| cs-ran.ran-core-ms-chart.configMap.storageClassName | string | `"gp2-persistent"` |  |
| cs-ran.ran-core-ms-chart.deployments.rancoremsDeployment.containers.rancoremsContainer.envs.AWS_RADCOM_CDF_CONTROL_INTF_NAMES | string | `"eth0"` |  |
| cs-ran.ran-core-ms-chart.deployments.rancoremsDeployment.containers.rancoremsContainer.envs.AWS_RADCOM_DEFAULT_INTF_NAMES | string | `"eth0"` |  |
| cs-ran.ran-core-ms-chart.deployments.rancoremsDeployment.containers.rancoremsContainer.envs.AWS_RADCOM_NF_MANAGER_INTF_NAMES | string | `"eth0"` |  |
| cs-ran.ran-core-ms-chart.deployments.rancoremsDeployment.containers.rancoremsContainer.envs.AWS_RADCOM_OAM_DIRECT_INTF_NAMES | string | `"eth0"` |  |
| cs-ran.ran-core-ms-chart.deployments.rancoremsDeployment.containers.rancoremsContainer.envs.AWS_RADCOM_PACKET_INTERNAL_INTF_NAMES | string | `"net1"` |  |
| cs-ran.ran-core-ms-chart.deployments.rancoremsDeployment.containers.rancoremsContainer.envs.AWS_RADCOM_TRAFFIC_DATA_INTF_NAMES | string | `"eth0"` |  |
| cs-ran.ran-core-ms-chart.deployments.rancoremsDeployment.podAnnotations."k8s.v1.cni.cncf.io/networks" | string | `"dpdk-net-internal-ran-100"` |  |
| cs-ran.ran-core-ms-chart.resources.limits.cpu | string | `"10000m"` |  |
| cs-ran.ran-core-ms-chart.resources.limits.hugepages1Gi | int | `1` |  |
| cs-ran.ran-core-ms-chart.resources.limits.memory | string | `"8Gi"` |  |
| cs-ran.ran-core-ms-chart.resources.requests.cpu | string | `"10000m"` |  |
| cs-ran.ran-core-ms-chart.resources.requests.hugepages1Gi | int | `1` |  |
| cs-ran.ran-core-ms-chart.resources.requests.memory | string | `"8Gi"` |  |
| cs-ran.ran-core-ms-chart.services.ranprobe-srv-internal.clusterIP | string | `"None"` |  |
| cs-ran.ran-core-ms-chart.services.ranprobe-srv-internal.name | string | `"ran-srv-internal-100"` |  |
| cs-ran.ran-core-ms-chart.services.ranprobe-srv-internal.ports[0].name | string | `"srv-interanal"` |  |
| cs-ran.ran-core-ms-chart.services.ranprobe-srv-internal.ports[0].port | int | `8010` |  |
| cs-ran.ran-core-ms-chart.services.ranprobe-srv-internal.ports[0].protocol | string | `"TCP"` |  |
| cs-ran.ran-core-ms-chart.services.ranprobe-srv-internal.ports[0].targetPort | int | `8010` |  |
| cs-ran.ran-core-ms-chart.services.ranprobe-srv-internal.sessionAffinity | string | `"None"` |  |
| cs-ran.ran-core-ms-chart.services.ranprobe-srv-internal.type | string | `"ClusterIP"` |  |
| cs-ran.ran-core-ms-chart.services.ranprobe-trafficdata.externalTrafficPolicy | string | `"Cluster"` |  |
| cs-ran.ran-core-ms-chart.services.ranprobe-trafficdata.name | string | `"ran-srv-trafficdata-100"` |  |
| cs-ran.ran-core-ms-chart.services.ranprobe-trafficdata.ports[0].name | string | `"trafficdata"` |  |
| cs-ran.ran-core-ms-chart.services.ranprobe-trafficdata.ports[0].port | int | `7004` |  |
| cs-ran.ran-core-ms-chart.services.ranprobe-trafficdata.ports[0].protocol | string | `"TCP"` |  |
| cs-ran.ran-core-ms-chart.services.ranprobe-trafficdata.ports[0].targetPort | int | `7004` |  |
| cs-ran.ran-core-ms-chart.services.ranprobe-trafficdata.sessionAffinity | string | `"None"` |  |
| cs-ran.ran-core-ms-chart.services.ranprobe-trafficdata.type | string | `"NodePort"` |  |
| cs-ran.ran-core-ms-chart.storagePVC.storageSize | string | `"20Gi"` |  |
| global.configMap.probeId | string | `"100"` |  |
| shared-templates.add_blueprints | bool | `false` |  |
| shared-templates.save_blueprint | bool | `false` |  |
| shared-templates.wait_for_ace_orchestrator | bool | `false` |  |

