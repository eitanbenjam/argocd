# oam-agent

![Version: 14.01.04](https://img.shields.io/badge/Version-14.01.04-informational?style=flat-square) ![AppVersion: 1.0](https://img.shields.io/badge/AppVersion-1.0-informational?style=flat-square)

oam-agent

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cs-oam-agent.auto-discovery-chart.autoDiscovery | object | `{}` |  |
| cs-oam-agent.elasticsearch-chart.data.persistence | object | `{}` |  |
| cs-oam-agent.elasticsearch-chart.master.persistence | object | `{}` |  |
| cs-oam-agent.prometheus-operator-chart.alertmanager.alertmanagerSpec.storage.volumeClaimTemplate.spec | object | `{}` |  |
| cs-oam-agent.prometheus-operator-chart.prometheus.prometheusSpec.storageSpec.volumeClaimTemplate.spec | object | `{}` |  |
| cs-oam-agent.service-access-config-chart.deployments.serviceAccessJob.enabled | bool | `true` |  |
| cs-oam-agent.service-access-config-chart.radcomConfiguration | object | `{}` |  |
| cs-oam-agent.wait_for_ace_orchestrator | bool | `false` |  |
| shared-templates.save_blueprint | bool | `false` |  |
| shared-templates.wait_for_ace_orchestrator | bool | `false` |  |
| shared-templates.wait_for_event_bus | bool | `false` |  |

