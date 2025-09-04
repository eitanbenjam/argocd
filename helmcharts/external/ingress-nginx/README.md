# ingress-nginx

![Version: 1.11.1](https://img.shields.io/badge/Version-1.11.1-informational?style=flat-square) ![AppVersion: 1.11.1](https://img.shields.io/badge/AppVersion-1.11.1-informational?style=flat-square)

A Helm chart for Nginx ingress.

## Requirements

Kubernetes: `>=1.23.0-0`

| Repository | Name | Version |
|------------|------|---------|
| https://kubernetes.github.io/ingress-nginx | ingress-nginx(ingress-nginx) | 4.13.2 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ingress-nginx.controller.allowSnippetAnnotations | bool | `true` |  |
| ingress-nginx.controller.config.annotations-risk-level | string | `"Critical"` |  |
| ingress-nginx.controller.extraArgs.default-ssl-certificate | string | `"ingress-nginx/wildcard-radcom-co-il-certificate"` |  |
| ingress-nginx.controller.metrics.enabled | bool | `true` |  |

