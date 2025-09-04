# vaultwarden

![Version: 1.11.1](https://img.shields.io/badge/Version-1.11.1-informational?style=flat-square) ![AppVersion: 1.11.1](https://img.shields.io/badge/AppVersion-1.11.1-informational?style=flat-square)

Unofficial Bitwarden compatible server written in Rust

## Requirements

Kubernetes: `>=1.16.0-0`

| Repository | Name | Version |
|------------|------|---------|
| file://../../radcom/library-chart | library-chart(library-chart) | 1.11.1 |
| https://gissilabs.github.io/charts/ | vaultwarden | 1.2.6 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| libraryChart.cronjob.args[0] | string | `"set -x && \\\napk add --no-cache curl && \\\nbackup_name=$(date +%Y_%m_%dT%H_%M)_data-backup.tar.gz && \\\ntar -czf ${backup_name} -C /data . && \\\ncurl -u ${NEXUS_USER}:${NEXUS_PASSWORD} -T ${backup_name} https://nexus3-prod.radcom.co.il/repository/radcom-files/backups/vaultwarden/${backup_name} && \\\necho \"Backup and upload completed!\"\n"` |  |
| libraryChart.cronjob.command[0] | string | `"/bin/sh"` |  |
| libraryChart.cronjob.command[1] | string | `"-c"` |  |
| libraryChart.cronjob.env[0].name | string | `"NEXUS_USER"` |  |
| libraryChart.cronjob.env[0].valueFrom.secretKeyRef.key | string | `"user"` |  |
| libraryChart.cronjob.env[0].valueFrom.secretKeyRef.name | string | `"nexus-credentials"` |  |
| libraryChart.cronjob.env[1].name | string | `"NEXUS_PASSWORD"` |  |
| libraryChart.cronjob.env[1].valueFrom.secretKeyRef.key | string | `"password"` |  |
| libraryChart.cronjob.env[1].valueFrom.secretKeyRef.name | string | `"nexus-credentials"` |  |
| libraryChart.cronjob.image.name | string | `"alpine"` |  |
| libraryChart.cronjob.image.tag | string | `"latest"` |  |
| libraryChart.cronjob.name | string | `"vaultwarden-backup"` |  |
| libraryChart.cronjob.resources.limits.cpu | string | `"500m"` |  |
| libraryChart.cronjob.resources.limits.memory | string | `"128Mi"` |  |
| libraryChart.cronjob.restartPolicy | string | `"OnFailure"` |  |
| libraryChart.cronjob.schedule | string | `"23 4 * * *"` |  |
| libraryChart.cronjob.volumeMounts[0].mountPath | string | `"/data"` |  |
| libraryChart.cronjob.volumeMounts[0].name | string | `"data-volume"` |  |
| libraryChart.cronjob.volumeMounts[0].readOnly | bool | `true` |  |
| libraryChart.cronjob.volumes[0].name | string | `"data-volume"` |  |
| libraryChart.cronjob.volumes[0].persistentVolumeClaim.claimName | string | `"vaultwarden"` |  |
| vaultwarden.database.type | string | `"sqlite"` |  |
| vaultwarden.ingress.annotations."kubernetes.io/ingress.class" | string | `"nginx"` |  |
| vaultwarden.ingress.annotations."kubernetes.io/tls-acme" | string | `"true"` |  |
| vaultwarden.ingress.className | string | `"nginx"` |  |
| vaultwarden.ingress.enabled | bool | `true` |  |
| vaultwarden.ingress.host | string | `"password.radcom.co.il"` |  |
| vaultwarden.ingress.tls[0].hosts[0] | string | `"password.radcom.co.il"` |  |
| vaultwarden.ingress.tls[0].secretName | string | `"wildcard-radcom-co-il-certificate"` |  |
| vaultwarden.persistence.accessMode | string | `"ReadWriteOnce"` |  |
| vaultwarden.persistence.enabled | bool | `true` |  |
| vaultwarden.persistence.size | string | `"1Gi"` |  |
| vaultwarden.vaultwarden.admin.enabled | bool | `true` |  |

