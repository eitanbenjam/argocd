# sonarqube

![Version: 1.11.0](https://img.shields.io/badge/Version-1.11.0-informational?style=flat-square) ![AppVersion: 1.11.0](https://img.shields.io/badge/AppVersion-1.11.0-informational?style=flat-square)

Official Sonarqube helm chart

## Requirements

Kubernetes: `>=1.16.0-0`

| Repository | Name | Version |
|------------|------|---------|
| file://../library-chart | library-chart(library-chart) | 1.11.1 |
| https://SonarSource.github.io/helm-chart-sonarqube | sonarqube | 2025.4.2 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| sonarqube.community.enabled | bool | `true` |  |
| sonarqube.ingress.annotations."nginx.ingress.kubernetes.io/proxy-body-size" | string | `"20M"` |  |
| sonarqube.ingress.enabled | bool | `true` |  |
| sonarqube.ingress.hosts[0].name | string | `"sonarqube.radcom.co.il"` |  |
| sonarqube.ingress.ingressClassName | string | `"nginx"` |  |
| sonarqube.ingress.tls[0].hosts[0] | string | `"sonarqube.radcom.co.il"` |  |
| sonarqube.ingress.tls[0].secretName | string | `"wildcard-radcom-co-il-certificate"` |  |
| sonarqube.monitoringPasscodeSecretKey | string | `"monitoringPasscodeSecret"` |  |
| sonarqube.monitoringPasscodeSecretName | string | `"admin-password-secret-name"` |  |
| sonarqube.passwordSecretName | string | `"admin-password-secret-name"` |  |
| sonarqube.persistence.enabled | bool | `true` |  |

