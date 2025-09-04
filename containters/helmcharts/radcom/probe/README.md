# probe

![Version: 14.01.04](https://img.shields.io/badge/Version-14.01.04-informational?style=flat-square) ![AppVersion: 1.0](https://img.shields.io/badge/AppVersion-1.0-informational?style=flat-square)

probe

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cs-probe.probe-core-ms-chart.configMap.cdfConfigurationName | string | `""` |  |
| cs-probe.probe-core-ms-chart.configMap.cdfGroup | string | `"group1"` |  |
| cs-probe.probe-core-ms-chart.configMap.cdfSubType | string | `""` |  |
| cs-probe.probe-core-ms-chart.configMap.clusterName | string | `"CProbe"` |  |
| cs-probe.probe-core-ms-chart.configMap.cprobeStandAlone | string | `"disable"` |  |
| cs-probe.probe-core-ms-chart.configMap.interfaceNames | string | `""` |  |
| cs-probe.probe-core-ms-chart.configMap.machineType | string | `"cProbe"` |  |
| cs-probe.probe-core-ms-chart.configMap.name | string | `"cProbe"` |  |
| cs-probe.probe-core-ms-chart.configMap.networkIpMode | string | `"ipv4"` |  |
| cs-probe.probe-core-ms-chart.configMap.prometheusAllPort | string | `"10091"` |  |
| cs-probe.probe-core-ms-chart.configMap.prometheusPort | string | `"10090"` |  |
| cs-probe.probe-core-ms-chart.configMap.tenant | string | `"probe"` |  |
| cs-probe.probe-core-ms-chart.configMap.vprobeType | string | `"mix"` |  |
| cs-probe.probe-core-ms-chart.configPVC.storageSize | string | `"2Gi"` |  |
| cs-probe.probe-core-ms-chart.dataPVC.storageSize | string | `"20Gi"` |  |
| cs-probe.probe-core-ms-chart.resources.limit.cpu | string | `"6000m"` |  |
| cs-probe.probe-core-ms-chart.resources.limit.hugepages1Gi | string | `"1"` |  |
| cs-probe.probe-core-ms-chart.resources.limit.memory | string | `"8Gi"` |  |
| cs-probe.probe-core-ms-chart.resources.requests.cpu | string | `"6000m"` |  |
| cs-probe.probe-core-ms-chart.resources.requests.hugepages1Gi | string | `"1"` |  |
| cs-probe.probe-core-ms-chart.resources.requests.memory | string | `"8Gi"` |  |
| global.configMap.probeId | string | `"100001"` |  |
| shared-templates.add_blueprints | bool | `false` |  |
| shared-templates.save_blueprint | bool | `true` |  |
| shared-templates.wait_for_ace_orchestrator | bool | `true` |  |

