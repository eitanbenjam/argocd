# lgtm

![Version: 1.12.0](https://img.shields.io/badge/Version-1.12.0-informational?style=flat-square) ![AppVersion: 1.12.0](https://img.shields.io/badge/AppVersion-1.12.0-informational?style=flat-square)

A Helm chart for LGTM ( Loki, Grafana, Tempo, Mimir ).

## Requirements

Kubernetes: `>=1.23.0-0`

| Repository | Name | Version |
|------------|------|---------|
| https://grafana.github.io/helm-charts | grafana(grafana) | 9.4.3 |
| https://grafana.github.io/helm-charts | grafana-mcp(grafana-mcp) | 0.1.2 |
| https://grafana.github.io/helm-charts | loki(loki-distributed) | 0.80.5 |
| https://grafana.github.io/helm-charts | mimir(mimir-distributed) | 5.8.0 |
| https://grafana.github.io/helm-charts | tempo(tempo-distributed) | 1.47.1 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| enabled | bool | `false` |  |
| grafana-mcp | object | `{"enabled":true,"grafana":{"apiKeySecret":{"key":"api-key","name":"grafana-mcp-api"},"url":"https://grafana.radcom.co.il"}}` | Grafana MCP (Model Context Protocol) server configuration |
| grafana."grafana.ini"."auth.azuread".allow_sign_up | bool | `true` |  |
| grafana."grafana.ini"."auth.azuread".allowed_organizations | string | `"0eb9e2d9-8763-412e-9709-3f539e9e25bc"` |  |
| grafana."grafana.ini"."auth.azuread".auth_url | string | `"https://login.microsoftonline.com/0eb9e2d9-8763-412e-9709-3f539e9e25bc/oauth2/v2.0/authorize"` |  |
| grafana."grafana.ini"."auth.azuread".auto_login | bool | `false` |  |
| grafana."grafana.ini"."auth.azuread".enabled | bool | `true` |  |
| grafana."grafana.ini"."auth.azuread".name | string | `"Azure AD"` |  |
| grafana."grafana.ini"."auth.azuread".role_attribute_path | string | `"contains(groups[*], 'DevOps') && 'Admin' || contains(groups[*], 'Devops-grafana-editors') && 'Admin' || 'Viewer'"` |  |
| grafana."grafana.ini"."auth.azuread".scopes | string | `"openid email profile"` |  |
| grafana."grafana.ini"."auth.azuread".token_url | string | `" https://login.microsoftonline.com/0eb9e2d9-8763-412e-9709-3f539e9e25bc/oauth2/v2.0/token"` |  |
| grafana."grafana.ini".dashboards.min_refresh_interval | string | `"5s"` |  |
| grafana."grafana.ini".feature_toggles.enable | string | `"correlations autoMigrateOldPanels traceQLStreaming externalServiceAccounts dashboardPreviews nestedFolders panelTitleSearch publicDashboards publicDashboardsEmailSharing dashboardComments"` |  |
| grafana."grafana.ini".server.root_url | string | `"https://grafana.radcom.co.il"` |  |
| grafana."grafana.ini".smtp.cert_file | string | `""` |  |
| grafana."grafana.ini".smtp.ehlo_identity | string | `""` |  |
| grafana."grafana.ini".smtp.enabled | bool | `true` |  |
| grafana."grafana.ini".smtp.from_address | string | `"devops@radcom.com"` |  |
| grafana."grafana.ini".smtp.from_name | string | `"Grafana"` |  |
| grafana."grafana.ini".smtp.host | string | `"172.16.1.125:25"` |  |
| grafana."grafana.ini".smtp.key_file | string | `""` |  |
| grafana."grafana.ini".smtp.skip_verify | bool | `true` |  |
| grafana."grafana.ini".smtp.startTLS_policy | string | `""` |  |
| grafana.admin.existingSecret | string | `"lgtm-grafana"` |  |
| grafana.admin.passwordKey | string | `"admin-password"` |  |
| grafana.admin.userKey | string | `"admin-user"` |  |
| grafana.adminUser | string | `"admin"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".apiVersion | int | `1` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].disableDeletion | bool | `true` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].editable | bool | `true` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].folder | string | `"VM Node Exporter"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].name | string | `"vm-node-exporter"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].options.path | string | `"/var/lib/grafana/dashboards/vm-node-exporter"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].orgId | int | `1` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[0].type | string | `"file"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[1].disableDeletion | bool | `true` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[1].editable | bool | `true` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[1].folder | string | `"Logs"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[1].name | string | `"Logs"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[1].options.path | string | `"/var/lib/grafana/dashboards/logs"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[1].orgId | int | `1` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[1].type | string | `"file"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[2].disableDeletion | bool | `true` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[2].editable | bool | `true` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[2].folder | string | `"Nginx"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[2].name | string | `"nginx"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[2].options.path | string | `"/var/lib/grafana/dashboards/nginx"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[2].orgId | int | `1` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[2].type | string | `"file"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[3].disableDeletion | bool | `true` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[3].editable | bool | `true` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[3].folder | string | `"Kubernetes"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[3].name | string | `"grafana-dashboards-kubernetes"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[3].options.path | string | `"/var/lib/grafana/dashboards/grafana-dashboards-kubernetes"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[3].orgId | int | `1` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[3].type | string | `"file"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[4].disableDeletion | bool | `true` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[4].editable | bool | `true` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[4].folder | string | `"Opencost"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[4].name | string | `"opencost"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[4].options.path | string | `"/var/lib/grafana/dashboards/opencost"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[4].orgId | int | `1` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[4].type | string | `"file"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[5].disableDeletion | bool | `true` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[5].editable | bool | `true` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[5].folder | string | `"Jenkins"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[5].name | string | `"jenkins"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[5].options.path | string | `"/var/lib/grafana/dashboards/jenkins"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[5].orgId | int | `1` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[5].type | string | `"file"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[6].disableDeletion | bool | `true` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[6].editable | bool | `true` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[6].folder | string | `"OpenStack"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[6].name | string | `"openstack"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[6].options.path | string | `"/var/lib/grafana/dashboards/openstack"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[6].orgId | int | `1` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[6].type | string | `"file"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[7].disableDeletion | bool | `true` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[7].editable | bool | `true` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[7].folder | string | `"JVM"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[7].name | string | `"jvm"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[7].options.path | string | `"/var/lib/grafana/dashboards/jvm"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[7].orgId | int | `1` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[7].type | string | `"file"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[8].disableDeletion | bool | `true` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[8].editable | bool | `true` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[8].folder | string | `"Ceph"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[8].name | string | `"ceph"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[8].options.path | string | `"/var/lib/grafana/dashboards/ceph"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[8].orgId | int | `1` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[8].type | string | `"file"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[9].disableDeletion | bool | `true` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[9].editable | bool | `true` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[9].folder | string | `"Nexus"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[9].name | string | `"nexus"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[9].options.path | string | `"/var/lib/grafana/dashboards/nexus"` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[9].orgId | int | `1` |  |
| grafana.dashboardProviders."dashboardproviders.yaml".providers[9].type | string | `"file"` |  |
| grafana.dashboards.ceph.ceph-cluster.datasource | string | `"Mimir"` |  |
| grafana.dashboards.ceph.ceph-cluster.gnetId | int | `2842` |  |
| grafana.dashboards.ceph.ceph-osd.datasource | string | `"Mimir"` |  |
| grafana.dashboards.ceph.ceph-osd.gnetId | int | `5336` |  |
| grafana.dashboards.ceph.ceph-pools.datasource | string | `"Mimir"` |  |
| grafana.dashboards.ceph.ceph-pools.gnetId | int | `5342` |  |
| grafana.dashboards.grafana-dashboards-kubernetes.k8s-resources-cluster.datasource | string | `"Mimir"` |  |
| grafana.dashboards.grafana-dashboards-kubernetes.k8s-resources-cluster.gnetId | int | `15761` |  |
| grafana.dashboards.grafana-dashboards-kubernetes.k8s-resources-cluster.revision | int | `4` |  |
| grafana.dashboards.grafana-dashboards-kubernetes.k8s-system-api-server.token | string | `""` |  |
| grafana.dashboards.grafana-dashboards-kubernetes.k8s-system-api-server.url | string | `"https://raw.githubusercontent.com/dotdc/grafana-dashboards-kubernetes/master/dashboards/k8s-system-api-server.json"` |  |
| grafana.dashboards.grafana-dashboards-kubernetes.k8s-system-coredns.token | string | `""` |  |
| grafana.dashboards.grafana-dashboards-kubernetes.k8s-system-coredns.url | string | `"https://raw.githubusercontent.com/dotdc/grafana-dashboards-kubernetes/master/dashboards/k8s-system-coredns.json"` |  |
| grafana.dashboards.grafana-dashboards-kubernetes.k8s-views-global.token | string | `""` |  |
| grafana.dashboards.grafana-dashboards-kubernetes.k8s-views-global.url | string | `"https://raw.githubusercontent.com/dotdc/grafana-dashboards-kubernetes/master/dashboards/k8s-views-global.json"` |  |
| grafana.dashboards.grafana-dashboards-kubernetes.k8s-views-namespaces.token | string | `""` |  |
| grafana.dashboards.grafana-dashboards-kubernetes.k8s-views-namespaces.url | string | `"https://raw.githubusercontent.com/dotdc/grafana-dashboards-kubernetes/master/dashboards/k8s-views-namespaces.json"` |  |
| grafana.dashboards.grafana-dashboards-kubernetes.k8s-views-nodes.token | string | `""` |  |
| grafana.dashboards.grafana-dashboards-kubernetes.k8s-views-nodes.url | string | `"https://raw.githubusercontent.com/dotdc/grafana-dashboards-kubernetes/master/dashboards/k8s-views-nodes.json"` |  |
| grafana.dashboards.grafana-dashboards-kubernetes.k8s-views-pods.token | string | `""` |  |
| grafana.dashboards.grafana-dashboards-kubernetes.k8s-views-pods.url | string | `"https://raw.githubusercontent.com/dotdc/grafana-dashboards-kubernetes/master/dashboards/k8s-views-pods.json"` |  |
| grafana.dashboards.grafana-dashboards-kubernetes.k8s-views-volumes.datasource | string | `"Mimir"` |  |
| grafana.dashboards.grafana-dashboards-kubernetes.k8s-views-volumes.gnetId | int | `17092` |  |
| grafana.dashboards.grafana-dashboards-kubernetes.k8s-views-volumes.revision | int | `4` |  |
| grafana.dashboards.grafana-dashboards-kubernetes.node-exporter-full.datasource | string | `"Mimir"` |  |
| grafana.dashboards.grafana-dashboards-kubernetes.node-exporter-full.gnetId | int | `1860` |  |
| grafana.dashboards.grafana-dashboards-kubernetes.node-exporter-full.revision | int | `30` |  |
| grafana.dashboards.jenkins.jenkins-overview.datasource | string | `"Mimir"` |  |
| grafana.dashboards.jenkins.jenkins-overview.gnetId | int | `10242` |  |
| grafana.dashboards.jenkins.jenkins-performance.datasource | string | `"Mimir"` |  |
| grafana.dashboards.jenkins.jenkins-performance.gnetId | int | `9964` |  |
| grafana.dashboards.jvm.jvm-detailed.datasource | string | `"Mimir"` |  |
| grafana.dashboards.jvm.jvm-detailed.gnetId | int | `17359` |  |
| grafana.dashboards.jvm.jvm-micrometer.datasource | string | `"Mimir"` |  |
| grafana.dashboards.jvm.jvm-micrometer.gnetId | int | `4701` |  |
| grafana.dashboards.logs.logs.datasource | string | `"Loki"` |  |
| grafana.dashboards.logs.logs.gnetId | int | `13639` |  |
| grafana.dashboards.nexus.nexus-overview.datasource | string | `"Mimir"` |  |
| grafana.dashboards.nexus.nexus-overview.gnetId | int | `14031` |  |
| grafana.dashboards.nexus.nexus-repository-manager.datasource | string | `"Mimir"` |  |
| grafana.dashboards.nexus.nexus-repository-manager.gnetId | int | `11963` |  |
| grafana.dashboards.nginx.nextGen.token | string | `""` |  |
| grafana.dashboards.nginx.nextGen.url | string | `"https://raw.githubusercontent.com/DevOps-Nirvana/Grafana-Dashboards/refs/heads/main/kubernetes-nginx-ingress-via-prometheus.json"` |  |
| grafana.dashboards.nginx.overview.gnetId | int | `16677` |  |
| grafana.dashboards.nginx.requestHandlingPerformance.gnetId | int | `20510` |  |
| grafana.dashboards.opencost.opencost-namespace.token | string | `""` |  |
| grafana.dashboards.opencost.opencost-namespace.url | string | `"https://raw.githubusercontent.com/adinhodovic/opencost-mixin/refs/heads/main/dashboards_out/opencost-mixin-namespace.json"` |  |
| grafana.dashboards.opencost.opencost-overview.token | string | `""` |  |
| grafana.dashboards.opencost.opencost-overview.url | string | `"https://raw.githubusercontent.com/adinhodovic/opencost-mixin/refs/heads/main/dashboards_out/opencost-mixin-overview.json"` |  |
| grafana.dashboards.openstack.openstack-cinder.datasource | string | `"Mimir"` |  |
| grafana.dashboards.openstack.openstack-cinder.gnetId | int | `10530` |  |
| grafana.dashboards.openstack.openstack-neutron.datasource | string | `"Mimir"` |  |
| grafana.dashboards.openstack.openstack-neutron.gnetId | int | `11132` |  |
| grafana.dashboards.openstack.openstack-nova.datasource | string | `"Mimir"` |  |
| grafana.dashboards.openstack.openstack-nova.gnetId | int | `15759` |  |
| grafana.dashboards.openstack.openstack-overview.datasource | string | `"Mimir"` |  |
| grafana.dashboards.openstack.openstack-overview.gnetId | int | `10531` |  |
| grafana.dashboards.vm-node-exporter.radcomNodeExporters.datasource | string | `"Mimir"` |  |
| grafana.dashboards.vm-node-exporter.radcomNodeExporters.gnetId | int | `1860` |  |
| grafana.datasources."datasources.yaml".apiVersion | int | `1` |  |
| grafana.datasources."datasources.yaml".datasources | list | `[{"isDefault":false,"name":"Loki","type":"loki","uid":"loki","url":"http://loki.radcom.co.il"},{"isDefault":true,"name":"Mimir","type":"prometheus","uid":"prom","url":"http://{{ .Release.Name }}-mimir-nginx/prometheus"}]` | Datasources linked to the Grafana instance. Override if you disable any components. |
| grafana.enabled | bool | `true` | Deploy Grafana if enabled. See [upstream readme](https://github.com/grafana/helm-charts/tree/main/charts/grafana#configuration) for full values reference. |
| grafana.env.GF_AUTH_MANAGED_SERVICE_ACCOUNTS_ENABLED | bool | `true` |  |
| grafana.envFromSecrets[0].name | string | `"alertmanager-credentials"` |  |
| grafana.envFromSecrets[1].name | string | `"lgtm-smtp-credentials"` |  |
| grafana.envValueFrom.GF_AUTH_AZUREAD_CLIENT_ID.secretKeyRef.key | string | `"CLIENT_ID"` |  |
| grafana.envValueFrom.GF_AUTH_AZUREAD_CLIENT_ID.secretKeyRef.name | string | `"grafana-azuread-credentials"` |  |
| grafana.envValueFrom.GF_AUTH_AZUREAD_CLIENT_SECRET.secretKeyRef.key | string | `"CLIENT_SECRET"` |  |
| grafana.envValueFrom.GF_AUTH_AZUREAD_CLIENT_SECRET.secretKeyRef.name | string | `"grafana-azuread-credentials"` |  |
| grafana.envValueFrom.GF_SMTP_PASSWORD.secretKeyRef.key | string | `"smtp-password"` |  |
| grafana.envValueFrom.GF_SMTP_PASSWORD.secretKeyRef.name | string | `"lgtm-smtp-credentials"` |  |
| grafana.envValueFrom.GF_SMTP_USER.secretKeyRef.key | string | `"smtp-user"` |  |
| grafana.envValueFrom.GF_SMTP_USER.secretKeyRef.name | string | `"lgtm-smtp-credentials"` |  |
| grafana.ingress.annotations."kubernetes.io/ingress.class" | string | `"nginx"` |  |
| grafana.ingress.annotations."kubernetes.io/tls-acme" | string | `"true"` |  |
| grafana.ingress.enabled | bool | `true` |  |
| grafana.ingress.extraPaths | list | `[]` |  |
| grafana.ingress.hosts[0] | string | `"grafana.radcom.co.il"` |  |
| grafana.ingress.ingressClassName | string | `"nginx"` |  |
| grafana.ingress.tls[0].hosts[0] | string | `"grafana.radcom.co.il"` |  |
| grafana.ingress.tls[0].secretName | string | `"wildcard-radcom-co-il-certificate"` |  |
| grafana.persistence.enabled | bool | `false` |  |
| grafana.persistence.size | string | `"10Gi"` |  |
| grafana.persistence.type | string | `"pvc"` |  |
| grafana.plugins[0] | string | `"https://storage.googleapis.com/integration-artifacts/grafana-lokiexplore-app/grafana-lokiexplore-app-latest.zip;grafana-lokiexplore-app"` |  |
| grafana.plugins[1] | string | `"grafana-piechart-panel"` |  |
| grafana.plugins[2] | string | `"grafana-clock-panel"` |  |
| grafana.plugins[3] | string | `"grafana-worldmap-panel"` |  |
| grafana.plugins[4] | string | `"grafana-kubernetes-app"` |  |
| grafana.plugins[5] | string | `"grafana-opensearch-datasource"` |  |
| grafana.plugins[6] | string | `"grafana-clickhouse-datasource"` |  |
| grafana.sidecar.alerts.enabled | bool | `true` |  |
| grafana.sidecar.alerts.envFromSecrets[0].name | string | `"alertmanager-credentials"` |  |
| grafana.sidecar.alerts.ignoreAlreadyProcessed | bool | `true` |  |
| grafana.sidecar.alerts.label | string | `"grafana_alert"` |  |
| grafana.sidecar.alerts.labelValue | string | `"alert"` |  |
| grafana.sidecar.alerts.provider.allowUiUpdates | bool | `true` |  |
| grafana.sidecar.alerts.provider.foldersFromFilesStructure | bool | `true` |  |
| grafana.sidecar.dashboards.SCProvider | bool | `true` |  |
| grafana.sidecar.dashboards.default.radcomNodeExporterFull.datasource | string | `"prom"` |  |
| grafana.sidecar.dashboards.default.radcomNodeExporterFull.gnetId | int | `1860` |  |
| grafana.sidecar.dashboards.defaultFolderName | string | `"General"` |  |
| grafana.sidecar.dashboards.enabled | bool | `true` |  |
| grafana.sidecar.dashboards.folderAnnotation | string | `"grafana_folder"` |  |
| grafana.sidecar.dashboards.label | string | `"grafana_dashboard"` |  |
| grafana.sidecar.dashboards.labelValue | string | `"dashboard"` |  |
| grafana.sidecar.dashboards.provider.allowUiUpdates | bool | `true` |  |
| grafana.sidecar.dashboards.provider.foldersFromFilesStructure | bool | `true` |  |
| grafana.sidecar.dashboards.searchIndexInterval | string | `"5m"` |  |
| grafana.sidecar.plugins.enabled | bool | `true` |  |
| lgtm-distributed.global.extraEnvFrom[0].secretRef.name | string | `"alertmanager-credentials"` |  |
| lgtm-distributed.global.podAnnotations.bucketSecretVersion | string | `"0"` |  |
| loki.compactor.enabled | bool | `true` |  |
| loki.compactor.retention_enabled | bool | `true` |  |
| loki.config | string | `"limits_config:\n  retention_period: 7d\n  volume_enabled: true\n  allow_structured_metadata: true\n  volume_max_series: 5000\n  discover_log_levels: true\ncompactor:\n  retention_enabled: true\npattern_ingester:\n  enabled: true\nruler:\n  alertmanager_url: \"http://lgtm-mimir-alertmanager.observability.svc.cluster.local/alertmanager\"\n  enable_api: true\n  ring:\n    kvstore:\n      store: memberlist\n  rule_path: \"/tmp/loki/scratch\"\n  storage:\n    type: local\n    local:\n      directory: \"/tmp/loki/rules\"\n  wal:\n    dir: \"/tmp/loki/ruler-wal\"\n"` |  |
| loki.containerSecurityContext.readOnlyRootFilesystem | bool | `false` |  |
| loki.enabled | bool | `true` | Deploy Loki if enabled. See [upstream readme](https://github.com/grafana/helm-charts/tree/main/charts/loki-distributed#values) for full values reference. |
| loki.gateway.enabled | bool | `false` |  |
| loki.ingress.annotations."kubernetes.io/ingress.class" | string | `"nginx"` |  |
| loki.ingress.annotations."kubernetes.io/tls-acme" | string | `"true"` |  |
| loki.ingress.annotations."nginx.ingress.kubernetes.io/ssl-redirect" | string | `"false"` |  |
| loki.ingress.enabled | bool | `true` |  |
| loki.ingress.hosts[0] | string | `"loki.radcom.co.il"` |  |
| loki.ingress.ingressClassName | string | `"nginx"` |  |
| loki.limits_config.allow_structured_metadata | bool | `true` |  |
| loki.limits_config.discover_log_levels | bool | `true` |  |
| loki.limits_config.retention_period | string | `"7d"` |  |
| loki.limits_config.volume_enabled | bool | `true` |  |
| loki.limits_config.volume_max_series | int | `5000` |  |
| loki.metaMonitoring.grafanaAgent.enabled | bool | `false` |  |
| loki.metaMonitoring.grafanaAgent.installOperator | bool | `false` |  |
| loki.metaMonitoring.grafanaAgent.logs.enabled | bool | `false` |  |
| loki.metaMonitoring.grafanaAgent.metrics.enabled | bool | `false` |  |
| loki.metaMonitoring.serviceMonitor.enabled | bool | `false` |  |
| loki.ruler.directories.fake."rules.txt" | string | `"groups:\n  - name: example\n    rules: []\n"` |  |
| loki.ruler.enabled | bool | `true` |  |
| loki.ruler.extraArgs[0] | string | `"-ruler.rule-path=/tmp/loki/scratch"` |  |
| loki.ruler.extraArgs[1] | string | `"-ruler.storage.type=local"` |  |
| loki.ruler.extraArgs[2] | string | `"-ruler.storage.local.directory=/tmp/loki/rules"` |  |
| metaMonitoring.grafanaAgent.enabled | bool | `false` |  |
| metaMonitoring.grafanaAgent.installOperator | bool | `false` |  |
| metaMonitoring.grafanaAgent.logs.enabled | bool | `false` |  |
| metaMonitoring.grafanaAgent.metrics.enabled | bool | `false` |  |
| metaMonitoring.serviceMonitor.enabled | bool | `false` |  |
| mimir | object | `{"alertmanager":{"persistentVolume":{"enabled":true}},"chunks-cache":{"enabled":true,"replicas":2},"compactor":{"limits":{"compactor_blocks_retention_period":"3d"},"persistentVolume":{"size":"20Gi"}},"distributor":{"extraArgs":{"distributor.ingestion-rate-limit":"10000000000000"},"replicas":2},"enabled":true,"ingester":{"affinity":{"podAntiAffinity":{"requiredDuringSchedulingIgnoredDuringExecution":[{"labelSelector":{"matchExpressions":[{"key":"target","operator":"In","values":["ingester"]}]},"topologyKey":"kubernetes.io/hostname"},{"labelSelector":{"matchExpressions":[{"key":"app.kubernetes.io/component","operator":"In","values":["ingester"]}]},"topologyKey":"kubernetes.io/hostname"}]}},"extraArgs":{"ingester.max-global-series-per-metric":"0","ingester.max-global-series-per-user":"0"},"persistentVolume":{"size":"50Gi"},"replicas":3,"zoneAwareReplication":{"topologyKey":"kubernetes.io/hostname"}},"metaMonitoring":{"grafanaAgent":{"enabled":false,"installOperator":false,"logs":{"enabled":false},"metrics":{"enabled":false}},"serviceMonitor":{"enabled":false}},"metadata-cache":{"enabled":true},"minio":{"persistence":{"size":"100Gi"}},"nginx":{"enabled":true,"ingress":{"annotations":{"kubernetes.io/ingress.class":"nginx","kubernetes.io/tls-acme":"true","nginx.ingress.kubernetes.io/ssl-redirect":"false"},"enabled":true,"hosts":[{"host":"mimir.radcom.co.il","paths":[{"path":"/","pathType":"Prefix"}]}],"ingressClassName":"nginx"},"replicas":1},"querier":{"replicas":1},"query_scheduler":{"replicas":1},"store_gateway":{"persistence":{"size":"2Gi"},"topologySpreadConstraints":{},"zoneAwareReplication":{"enabled":false}},"structuredConfig":{"limits":{"out_of_order_time_window":"12h"}}}` | Mimir chart values. Resources are set to a minimum by default. |
| mimir.enabled | bool | `true` | Deploy Mimir if enabled. See [upstream values.yaml](https://github.com/grafana/mimir/blob/main/operations/helm/charts/mimir-distributed/values.yaml) for full values reference. |
| silence.enabled | bool | `true` |  |
| silence.silences[0].comment | string | `"Silence alerts from sardina3-compute-03 host"` |  |
| silence.silences[0].createdBy | string | `"Marian Maireanu Dobos - Devops"` |  |
| silence.silences[0].endsAt | string | `"2026-07-09T14:00:00Z"` |  |
| silence.silences[0].matcher.isRegex | bool | `false` |  |
| silence.silences[0].matcher.name | string | `"hostname"` |  |
| silence.silences[0].matcher.value | string | `"sardina3-compute-03"` |  |
| silence.silences[0].startsAt | string | `"2025-07-09T12:00:00Z"` |  |
| tempo.enabled | bool | `false` | Deploy Tempo if enabled.  See [upstream readme](https://github.com/grafana/helm-charts/blob/main/charts/tempo-distributed/README.md#values) for full values reference. |
| tempo.ingester.replicas | int | `1` |  |
| tempo.metaMonitoring.grafanaAgent.enabled | bool | `false` |  |
| tempo.metaMonitoring.grafanaAgent.installOperator | bool | `false` |  |
| tempo.metaMonitoring.grafanaAgent.logs.enabled | bool | `false` |  |
| tempo.metaMonitoring.grafanaAgent.metrics.enabled | bool | `false` |  |
| tempo.metaMonitoring.serviceMonitor.enabled | bool | `false` |  |

