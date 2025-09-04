# ran-probe-a

![Version: 14.01.04](https://img.shields.io/badge/Version-14.01.04-informational?style=flat-square) ![AppVersion: 1.0](https://img.shields.io/badge/AppVersion-1.0-informational?style=flat-square)

ran-probe-a

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cs-ran.ran-core-ms-chart.cdrPVC.storageSize | string | `"2Gi"` |  |
| cs-ran.ran-core-ms-chart.configMap.clusterName | string | `"RAN"` |  |
| cs-ran.ran-core-ms-chart.configMap.machineType | string | `"RAN-probe-a"` |  |
| cs-ran.ran-core-ms-chart.configMap.name | string | `"ranProbe-a"` |  |
| cs-ran.ran-core-ms-chart.configMap.networkIpMode | string | `"ipv4"` |  |
| cs-ran.ran-core-ms-chart.configMap.trafficMirrorNetworkGateway | string | `""` |  |
| cs-ran.ran-core-ms-chart.resources.limits.cpu | string | `"10000m"` |  |
| cs-ran.ran-core-ms-chart.resources.limits.hugepages1Gi | int | `1` |  |
| cs-ran.ran-core-ms-chart.resources.limits.memory | string | `"8Gi"` |  |
| cs-ran.ran-core-ms-chart.resources.requests.cpu | string | `"10000m"` |  |
| cs-ran.ran-core-ms-chart.resources.requests.hugepages1Gi | int | `1` |  |
| cs-ran.ran-core-ms-chart.resources.requests.memory | string | `"8Gi"` |  |
| cs-ran.ran-core-ms-chart.storagePVC.storageSize | string | `"20Gi"` |  |
| global.configMap.probeId | string | `"10"` |  |
| shared-templates.add_blueprints | bool | `false` |  |
| shared-templates.save_blueprint | bool | `false` |  |
| shared-templates.wait_for_ace_orchestrator | bool | `false` |  |

