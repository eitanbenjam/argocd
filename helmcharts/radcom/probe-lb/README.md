# probe-lb

![Version: 14.01.04](https://img.shields.io/badge/Version-14.01.04-informational?style=flat-square) ![AppVersion: 1.0](https://img.shields.io/badge/AppVersion-1.0-informational?style=flat-square)

probe-lb

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cs-probe.probe-core-ms-chart.configMap.cdfConfigurationName | string | `""` |  |
| cs-probe.probe-core-ms-chart.configMap.cdfControlInterfacePref | string | `"AWS_RADCOM_CDF_CONTROL"` |  |
| cs-probe.probe-core-ms-chart.configMap.cdfGroup | string | `"group1"` |  |
| cs-probe.probe-core-ms-chart.configMap.cdfSubType | string | `""` |  |
| cs-probe.probe-core-ms-chart.configMap.clusterName | string | `"CLBA,CLB,CProbe"` |  |
| cs-probe.probe-core-ms-chart.configMap.cprobeStandAlone | string | `"disable"` |  |
| cs-probe.probe-core-ms-chart.configMap.defaultInterfacePref | string | `"AWS_RADCOM_DEFAULT"` |  |
| cs-probe.probe-core-ms-chart.configMap.interfaceNames | string | `"tcp"` |  |
| cs-probe.probe-core-ms-chart.configMap.machineType | string | `"CLBA,CLB,CProbe"` |  |
| cs-probe.probe-core-ms-chart.configMap.name | string | `"clb-values"` |  |
| cs-probe.probe-core-ms-chart.configMap.networkIpMode | string | `"ipv4"` |  |
| cs-probe.probe-core-ms-chart.configMap.nfManagerInterfacePref | string | `"AWS_RADCOM_NF_MANAGER"` |  |
| cs-probe.probe-core-ms-chart.configMap.oamDirectInterfacePref | string | `"AWS_RADCOM_OAM_DIRECT"` |  |
| cs-probe.probe-core-ms-chart.configMap.packetInternalInterfacePref | string | `"AWS_RADCOM_PACKET_INTERNAL"` |  |
| cs-probe.probe-core-ms-chart.configMap.packetMirrorInterfacePref | string | `"AWS_RADCOM_PACKET_MIRROR"` |  |
| cs-probe.probe-core-ms-chart.configMap.prometheusAllPort | string | `"10091"` |  |
| cs-probe.probe-core-ms-chart.configMap.prometheusPort | string | `"10090"` |  |
| cs-probe.probe-core-ms-chart.configMap.storageClassName | string | `"gp3-persistent"` |  |
| cs-probe.probe-core-ms-chart.configMap.tenant | string | `"probe"` |  |
| cs-probe.probe-core-ms-chart.configMap.trafficDataInterfacePref | string | `"AWS_RADCOM_TRAFFIC_DATA"` |  |
| cs-probe.probe-core-ms-chart.configMap.useNetworkAttachmentDefinition | string | `"yes"` |  |
| cs-probe.probe-core-ms-chart.configMap.vprobeType | string | `"mix"` |  |
| cs-probe.probe-core-ms-chart.configPVC.storageSize | string | `"2Gi"` |  |
| cs-probe.probe-core-ms-chart.dataPVC.storageSize | string | `"20Gi"` |  |
| cs-probe.probe-core-ms-chart.deployments.probecoremsDeployment.annotations."k8s.v1.cni.cncf.io/networks" | string | `"dpdk-net-internal-probe-100002"` |  |
| cs-probe.probe-core-ms-chart.deployments.probecoremsDeployment.containers.probecoremsContainer.env.AWS_RADCOM_CDF_CONTROL_INTF_NAMES | string | `"eth0"` |  |
| cs-probe.probe-core-ms-chart.deployments.probecoremsDeployment.containers.probecoremsContainer.env.AWS_RADCOM_DEFAULT_INTF_NAMES | string | `"eth0"` |  |
| cs-probe.probe-core-ms-chart.deployments.probecoremsDeployment.containers.probecoremsContainer.env.AWS_RADCOM_NF_MANAGER_INTF_NAMES | string | `"eth0"` |  |
| cs-probe.probe-core-ms-chart.deployments.probecoremsDeployment.containers.probecoremsContainer.env.AWS_RADCOM_OAM_DIRECT_INTF_NAMES | string | `"eth0"` |  |
| cs-probe.probe-core-ms-chart.deployments.probecoremsDeployment.containers.probecoremsContainer.env.AWS_RADCOM_PACKET_INTERNAL_INTF_NAMES | string | `"net1"` |  |
| cs-probe.probe-core-ms-chart.deployments.probecoremsDeployment.containers.probecoremsContainer.env.AWS_RADCOM_TRAFFIC_DATA_INTF_NAMES | string | `"eth0"` |  |
| cs-probe.probe-core-ms-chart.resources.limit.cpu | string | `"6000m"` |  |
| cs-probe.probe-core-ms-chart.resources.limit.hugepages1Gi | string | `"1"` |  |
| cs-probe.probe-core-ms-chart.resources.limit.memory | string | `"8Gi"` |  |
| cs-probe.probe-core-ms-chart.resources.requests.cpu | string | `"6000m"` |  |
| cs-probe.probe-core-ms-chart.resources.requests.hugepages1Gi | string | `"1"` |  |
| cs-probe.probe-core-ms-chart.resources.requests.memory | string | `"8Gi"` |  |
| global.configMap.probeId | string | `"100002"` |  |
| shared-templates.add_blueprints | bool | `false` |  |
| shared-templates.save_blueprint | bool | `false` |  |
| shared-templates.wait_for_ace_orchestrator | bool | `false` |  |

