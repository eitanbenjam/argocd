# renovate

![Version: 1.11.1](https://img.shields.io/badge/Version-1.11.1-informational?style=flat-square) ![AppVersion: 1.11.1](https://img.shields.io/badge/AppVersion-1.11.1-informational?style=flat-square)

A Helm chart for renovatebot.

## Requirements

Kubernetes: `>=1.23.0-0`

| Repository | Name | Version |
|------------|------|---------|
| https://docs.renovatebot.com/helm-charts | renovate(renovate) | 43.30.2 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| renovate.affinity | object | `{}` |  |
| renovate.containerSecurityContext.allowPrivilegeEscalation | bool | `false` |  |
| renovate.containerSecurityContext.capabilities.drop[0] | string | `"ALL"` |  |
| renovate.cronjob.failedJobsHistoryLimit | int | `1` | The number of failed finished jobs to retain |
| renovate.cronjob.schedule | string | `"0 2 * * 1,3,5"` | Schedules the job to run using cron notation |
| renovate.cronjob.startingDeadlineSeconds | int | `3600` | Deadline in seconds for starting the job if it misses scheduled time for any reason |
| renovate.cronjob.successfulJobsHistoryLimit | int | `3` | The number of successful finished jobs to retain |
| renovate.cronjob.suspend | bool | `false` | If it is set to true, all subsequent executions are suspended. This setting does not apply to already started executions. |
| renovate.cronjob.timeZone | string | `"UTC"` | You can specify a time zone for a CronJob by setting timeZone to the name of a valid time zone. (starting with k8s 1.27) <https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/#time-zones> |
| renovate.envFrom[0].secretRef.name | string | `"renovate-env"` |  |
| renovate.nodeSelector."kubernetes.io/os" | string | `"linux"` |  |
| renovate.renovate.config | string | `"{\n  \"gitAuthor\": \"Renovate Bot <devops@radcom.co.il>\",\n  \"repositories\": [\n    \"devopstools/helmcharts\",\n    \"sysc/radcom-manager-ms\",\n    \"kad/radcom-ingress-nginx\",\n    \"rcc/ace-cd\"\n  ],\n  \"prHourlyLimit\": 3,\n  \"prConcurrentLimit\": 5,\n  \"timezone\": \"UTC\",\n  \"labels\": [\"dependencies\", \"renovate-bot\"],\n  \"assignees\": [\"devops\"],\n  \"vulnerabilityAlerts\": {\n    \"enabled\": true\n  },\n  \"osvVulnerabilityAlerts\": true,\n  \"dependencyDashboard\": true,\n  \"dependencyDashboardTitle\": \"Dependency Dashboard\",\n  \"dependencyDashboardHeader\": \"This is an overview of Renovate updates and their statuses.\",\n  \"semanticCommits\": \"enabled\",\n  \"commitMessageTopic\": \"{{`{{depName}}`}}\",\n  \"commitMessageExtra\": \"to {{`{{newVersion}}`}}\",\n  \"branchPrefix\": \"chore/\",\n  \"hostRules\": [\n    {\n      \"hostType\": \"docker\",\n      \"matchHost\": \"docker.io\",\n      \"username\": \"{{`{{DOCKER_HUB_USERNAME}}`}}\",\n      \"password\": \"{{`{{DOCKER_HUB_PASSWORD}}`}}\",\n      \"timeout\": 60000\n    },\n    {\n      \"hostType\": \"docker\",\n      \"matchHost\": \"*.dkr.ecr.*.amazonaws.com\",\n      \"username\": \"{{`{{AWS_ACCESS_KEY_ID}}`}}\",\n      \"password\": \"{{`{{AWS_SECRET_ACCESS_KEY}}`}}\",\n      \"timeout\": 60000\n    },\n    {\n      \"matchHost\": \"nexus3-prod.radcom.co.il\",\n      \"hostType\": \"helm\",\n      \"username\": \"{{`{{NEXUS_USER}}`}}\",\n      \"password\": \"{{`{{NEXUS_PASSWORD}}`}}\",\n      \"timeout\": 60000\n    }\n  ]\n}\n"` |  |
| renovate.renovate.configEnableHelmTpl | bool | `true` |  |
| renovate.renovate.extraConfigmaps[0].data."config.js" | string | `"module.exports = {\n  hostRules: [\n    {\n      matchHost: \"nexus3-prod.radcom.co.il\",\n      username: process.env.NEXUS_USER,\n      password: process.env.NEXUS_PASSWORD,\n      timeout: 60000\n    },\n    {\n      hostType: \"docker\",\n      matchHost: \"docker.io\",\n      username: process.env.DOCKER_HUB_USERNAME,\n      password: process.env.DOCKER_HUB_PASSWORD,\n      timeout: 60000\n    }\n  ],\n  secrets: {\n    NEXUS_USER: process.env.NEXUS_USER,\n    NEXUS_PASSWORD: process.env.NEXUS_PASSWORD,\n    DOCKER_HUB_USERNAME: process.env.DOCKER_HUB_USERNAME,\n    DOCKER_HUB_PASSWORD: process.env.DOCKER_HUB_PASSWORD,\n  }\n};\n"` |  |
| renovate.renovate.extraConfigmaps[0].name | string | `"config"` |  |
| renovate.resources.limits.cpu | string | `"2000m"` |  |
| renovate.resources.limits.memory | string | `"4Gi"` |  |
| renovate.resources.requests.cpu | string | `"500m"` |  |
| renovate.resources.requests.memory | string | `"1Gi"` |  |
| renovate.securityContext.fsGroup | int | `1000` |  |
| renovate.securityContext.runAsNonRoot | bool | `true` |  |
| renovate.securityContext.runAsUser | int | `1000` |  |
| renovate.tolerations | list | `[]` |  |

