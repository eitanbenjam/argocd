# argo-cd

![Version: 1.11.1](https://img.shields.io/badge/Version-1.11.1-informational?style=flat-square) ![AppVersion: 1.11.1](https://img.shields.io/badge/AppVersion-1.11.1-informational?style=flat-square)

A Helm chart for Argo CD, a declarative, GitOps continuous delivery tool for Kubernetes.

## Requirements

Kubernetes: `>=1.23.0-0`

| Repository | Name | Version |
|------------|------|---------|
| https://argoproj.github.io/argo-helm | argo-cd(argo-cd) | 8.3.1 |
| https://dandydeveloper.github.io/charts/ | redis-ha | 4.33.8 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| argo-cd.configs.cm."exec.enabled" | bool | `true` |  |
| argo-cd.configs.cm."extension.config" | string | `"extensions:\n  - name: metrics\n    backend:\n      services:\n        - url: http://argocd-server-metrics.argocd.svc:9003"` |  |
| argo-cd.configs.cm."oidc.config" | string | `"name: AzureAD\nissuer: https://login.microsoftonline.com/0eb9e2d9-8763-412e-9709-3f539e9e25bc/v2.0\nclientID: a148ed9a-acc6-4753-91b4-a243779473a0\nclientSecret: $oidc.azure.clientSecret\nrequestedIDTokenClaims:\n  groups:\n    essential: true\nrequestedScopes:\n  - openid\n  - profile\n  - email\n"` |  |
| argo-cd.configs.cm.create | bool | `true` | Create the argocd-cm configmap for [declarative setup] |
| argo-cd.configs.params."server.enable.proxy.extension" | string | `"true"` |  |
| argo-cd.configs.rbac."policy.csv" | string | `''` (See [values.yaml]) | File containing user-defined policies and role definitions. policy.csv: '' Policy rules are in the form:  p, subject, resource, action, object, effect Role definitions and bindings are in the form:  g, subject, inherited-subject |
| argo-cd.configs.rbac."policy.default" | string | `"role:readonly"` | The name of the default role which Argo CD will falls back to, when authorizing API requests (optional). If omitted or empty, users may be still be able to login, but will see no apps, projects, etc... |
| argo-cd.configs.rbac."policy.matchMode" | string | `"glob"` | Matcher function for Casbin, `glob` for glob matcher and `regex` for regex matcher. |
| argo-cd.configs.rbac.annotations | object | `{}` | Annotations to be added to argocd-rbac-cm configmap |
| argo-cd.configs.rbac.create | bool | `true` | Create the argocd-rbac-cm configmap with ([Argo CD RBAC policy]) definitions. If false, it is expected the configmap will be created by something else. Argo CD will not work if there is no configmap created with the name above. |
| argo-cd.configs.rbac.scopes | string | `"[groups]"` | OIDC scopes to examine during rbac enforcement (in addition to `sub` scope). The scope value can be a string, or a list of strings. |
| argo-cd.fullnameOverride | string | `"argo-cd"` | String to fully override `"argo-cd.fullname"` |
| argo-cd.global.domain | string | `"argocd.radcom.co.il"` | Default domain used by all components # Used for ingresses, certificates, SSO, notifications, etc. |
| argo-cd.nameOverride | string | `"argo-cd"` | Provide a name in place of `argocd` |
| argo-cd.server.certificate.domain | string | `""` (defaults to global.domain) | Certificate primary domain (commonName) |
| argo-cd.server.certificate.enabled | bool | `false` | Deploy a Certificate resource (requires cert-manager) |
| argo-cd.server.extensions.enabled | bool | `true` | Enable support for Argo CD extensions |
| argo-cd.server.extensions.extensionList[0].env[0].name | string | `"EXTENSION_URL"` |  |
| argo-cd.server.extensions.extensionList[0].env[0].value | string | `"https://github.com/argoproj-labs/argocd-extension-metrics/releases/download/v1.0.3/extension.tar.gz"` |  |
| argo-cd.server.extensions.extensionList[0].env[1].name | string | `"EXTENSION_CHECKSUM_URL"` |  |
| argo-cd.server.extensions.extensionList[0].env[1].value | string | `"https://github.com/argoproj-labs/argocd-extension-metrics/releases/download/v1.0.3/extension_checksums.txt"` |  |
| argo-cd.server.extensions.extensionList[0].name | string | `"extension-metrics"` |  |
| argo-cd.server.ingress.annotations | object | `{"nginx.ingress.kubernetes.io/backend-protocol":"HTTPS","nginx.ingress.kubernetes.io/force-ssl-redirect":"true"}` | Additional ingress annotations # Ref: https://argo-cd.readthedocs.io/en/stable/operator-manual/ingress/#option-1-ssl-passthrough |
| argo-cd.server.ingress.controller | string | `"generic"` | Specific implementation for ingress controller. One of `generic`, `aws` or `gke` # Additional configuration might be required in related configuration sections |
| argo-cd.server.ingress.enabled | bool | `true` | Enable an ingress resource for the Argo CD server |
| argo-cd.server.ingress.ingressClassName | string | `"nginx"` | Defines which ingress controller will implement the resource |
| argo-cd.server.ingress.labels | object | `{}` | Additional ingress labels |
| argo-cd.server.ingress.tls | bool | `true` | Enable TLS configuration for the hostname defined at `server.ingress.hostname` # TLS certificate will be retrieved from a TLS secret `argocd-server-tls` # You can create this secret via `certificate` or `certificateSecret` option |

