# ansible-awx-operator

![Version: 1.11.1](https://img.shields.io/badge/Version-1.11.1-informational?style=flat-square) ![AppVersion: 1.11.1](https://img.shields.io/badge/AppVersion-1.11.1-informational?style=flat-square)

A Helm chart for Ansible AWX operator.

## Requirements

Kubernetes: `>=1.23.0-0`

| Repository | Name | Version |
|------------|------|---------|
| file://../../radcom/library-chart | library-chart(library-chart) | 1.11.1 |
| https://ansible-community.github.io/awx-operator-helm/ | awx-operator(awx-operator) | 3.2.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| awx-operator.AWX.enabled | bool | `true` |  |
| awx-operator.AWX.name | string | `"awx"` |  |
| awx-operator.AWX.postgres.dbName | string | `"Unset"` |  |
| awx-operator.AWX.postgres.enabled | bool | `false` |  |
| awx-operator.AWX.postgres.host | string | `"Unset"` |  |
| awx-operator.AWX.postgres.password | string | `"Unset"` |  |
| awx-operator.AWX.postgres.port | int | `5678` |  |
| awx-operator.AWX.postgres.sslmode | string | `"prefer"` |  |
| awx-operator.AWX.postgres.type | string | `"unmanaged"` |  |
| awx-operator.AWX.postgres.username | string | `"admin"` |  |
| awx-operator.AWX.spec.admin_user | string | `"admin"` |  |
| awx-operator.AWX.spec.ingress_annotations | string | `"nginx.ingress.kubernetes.io/force-ssl-redirect: \"true\"\nkubernetes.io/ingress.class: nginx\n"` |  |
| awx-operator.AWX.spec.ingress_hosts[0].hostname | string | `"awx.radcom.co.il"` |  |
| awx-operator.AWX.spec.ingress_hosts[0].tls_secret | string | `"wildcard-radcom-co-il-certificate"` |  |
| awx-operator.AWX.spec.ingress_path_type | string | `"Prefix"` |  |
| awx-operator.AWX.spec.ingress_type | string | `"ingress"` |  |
| awx-operator.AWX.spec.no_log | bool | `false` |  |
| awx-operator.AWX.spec.projects_persistence | bool | `true` |  |
| awx-operator.AWX.spec.projects_storage_access_mode | string | `"ReadWriteOnce"` |  |
| awx-operator.AWX.spec.projects_storage_size | string | `"5Gi"` |  |
| awx-operator.AWX.spec.secret_key_secret | string | `"custom-awx-secret-key"` |  |
| enabled | bool | `false` |  |
| libraryChart.cronjob.args[0] | string | `"set -x && \\\napk add curl && \\\nbackup_name_tar=awx_data-backup_$(date +%Y_%m_%dT%H_%M).tar && \\\npg_dump -p 5432 -h awx-postgres-15 -U awx -d awx -F t -b -f /tmp/${backup_name_tar} && \\\ncurl -u admin:admin123 -T /tmp/${backup_name_tar} https://nexus3-prod.radcom.co.il/repository/radcom-files/backups/awx/${backup_name_tar} && \\\necho \"Backup and upload completed!\"\n"` |  |
| libraryChart.cronjob.command[0] | string | `"/bin/sh"` |  |
| libraryChart.cronjob.command[1] | string | `"-c"` |  |
| libraryChart.cronjob.env[0].name | string | `"POSTGRES_PASSWORD"` |  |
| libraryChart.cronjob.env[0].valueFrom.secretKeyRef.key | string | `"password"` |  |
| libraryChart.cronjob.env[0].valueFrom.secretKeyRef.name | string | `"awx-postgres-configuration"` |  |
| libraryChart.cronjob.env[1].name | string | `"PGPASSWORD"` |  |
| libraryChart.cronjob.env[1].valueFrom.secretKeyRef.key | string | `"password"` |  |
| libraryChart.cronjob.env[1].valueFrom.secretKeyRef.name | string | `"awx-postgres-configuration"` |  |
| libraryChart.cronjob.env[2].name | string | `"NEXUS_USER"` |  |
| libraryChart.cronjob.env[2].valueFrom.secretKeyRef.key | string | `"user"` |  |
| libraryChart.cronjob.env[2].valueFrom.secretKeyRef.name | string | `"nexus-credentials"` |  |
| libraryChart.cronjob.env[3].name | string | `"NEXUS_PASSWORD"` |  |
| libraryChart.cronjob.env[3].valueFrom.secretKeyRef.key | string | `"password"` |  |
| libraryChart.cronjob.env[3].valueFrom.secretKeyRef.name | string | `"nexus-credentials"` |  |
| libraryChart.cronjob.image.name | string | `"postgres"` |  |
| libraryChart.cronjob.image.tag | string | `"15-alpine"` |  |
| libraryChart.cronjob.name | string | `"awx-backup"` |  |
| libraryChart.cronjob.restartPolicy | string | `"OnFailure"` |  |
| libraryChart.cronjob.schedule | string | `"21 2 * * *"` |  |

