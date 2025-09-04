# anchovy

![Version: 1.11.1](https://img.shields.io/badge/Version-1.11.1-informational?style=flat-square) ![AppVersion: 1.11.1](https://img.shields.io/badge/AppVersion-1.11.1-informational?style=flat-square)

A Helm chart for Anchovy RADCOM Sardina Stacks Browser

## Requirements

Kubernetes: `>=1.23.0-0`

| Repository | Name | Version |
|------------|------|---------|
| https://nexus3-prod.radcom.co.il/repository/charts | anchovy | 2.0.5 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| anchovy.image.repository | string | `"nexus3-prod.radcom.co.il:8084/anchovy"` |  |
| anchovy.ingress.className | string | `"nginx"` |  |
| anchovy.ingress.enabled | bool | `true` |  |
| anchovy.ingress.hosts[0].host | string | `"anchovy.radcom.co.il"` |  |
| anchovy.ingress.hosts[0].paths[0].path | string | `"/anchovy(/|$)(.*)"` |  |
| anchovy.ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| anchovy.ingress.hosts[1].http | string | `nil` |  |
| anchovy.ingress.hosts[1].paths[0].path | string | `"/anchovy(/|$)(.*)"` |  |
| anchovy.ingress.hosts[1].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| anchovy.ingress.tls[0].hosts[0] | string | `"anchovy.radcom.co.il"` |  |
| anchovy.ingress.tls[0].secretName | string | `"wildcard-radcom-co-il-certificate"` |  |
| anchovy.volumes.storageClassName | string | `"openebs-hostpath"` |  |

