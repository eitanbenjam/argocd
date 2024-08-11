{{- /*
radcom.merge will merge two YAML templates and output the result.
This takes an array of three values:
- the top context
- the template name of the overrides (destination)
- the template name of the base (source)
*/ -}}
{{- define "radcom.merge" -}}
{{- $top := first . -}}
{{- $overrides := fromYaml (include (index . 1) $top) | default (dict ) -}}
{{- $tpl := fromYaml (include (index . 2) $top) | default (dict ) -}}
{{- toYaml (merge $overrides $tpl) -}}
{{- end -}}
{{/*
Expand the name of the chart.
*/}}
{{- define "radcom.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "radcom.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "radcom.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "radcom.labels" -}}
helm.sh/chart: {{ include "radcom.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "radcom.selectorLabels" -}}
{{- $root := .root }}
{{- $name := "" }}
{{- with .name }}
  {{- $name = . -}}
{{- end -}}
app.kubernetes.io/name: {{ $name }}
app.kubernetes.io/instance: {{ $root.Release.Name }}
{{- if $root.Values.global }}
{{- if $root.Values.global.chartSet }}
radcom.com/chartSet: "{{ $root.Values.global.chartSet }}"
{{- else }}
radcom.com/chartSet: "noChartSet"
{{- end }}
{{- if $root.Values.global.labels }}
{{- range $key, $value := $root.Values.global.labels }}
{{ $key }}: {{ $value }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "radcom.serviceAccountName" -}}
{{- $root := .root }}
{{- if .serviceAccount }}
{{- if .serviceAccount.create }}
{{- default (printf "%s-%s" $root.Release.Name (include "radcom.fullname" $root)) .serviceAccount.name }}
{{- else }}
{{- default "default" .serviceAccount.name }}
{{- end }}
{{- else -}}
default
{{- end }}
{{- end }}

{{- define "radcom.configmapChecksum" -}}
{{ include (print $.Template.BasePath "/" (include "radcom.fullname" .) "_configmap.yaml") . | sha256sum }}
{{- end -}}

{{/*
Create ingress annotations
*/}}
{{- define "getContainersPorts" -}}
    {{- if .Values.services }}
    {{- $portList :=  list }}
    {{- range $currService := .Values.services -}}
    {{- range $portService := $currService.ports -}}
    {{- $portList = append  $portList (dict "containerPort" ( $portService.targetPort | default 8080 ) "protocol" ( $portService.protocol | default "TCP" ) "name" ( $portService.name | default "http" | trunc 15)) }}
    {{- end }}
    {{- end }}
    {{- toYaml $portList }}
    {{- end }}
{{- end }}

{{- define "getServicePort" -}}
    {{- $root := index . 0 }}
    {{- $ingressServiceName := tpl (index . 1) $root }}
    {{- $fullName := include "radcom.fullname" $root }}
    {{- $serviceName := printf "%s-%s" $fullName "srv" }}
    {{- if $root.Values.services }}
        {{- range $currService := $root.Values.services -}}
          {{- if $currService.name }}
            {{- $serviceName = tpl $currService.name $root }}
          {{- end }}
          {{- if eq $serviceName $ingressServiceName }}
          {{- range $ports := $currService.ports }}
            {{- $ports.port }}
          {{- end }}
          {{- end }}
        {{- end }}
    {{- end }}
{{- end }}


{{- define "getAdditionalAnnotations" -}}
    {{- $root := index . 0 }}
    {{- $AdditionalAnnotationsName := tpl ( (index . 1)) $root }}    
    {{- range $currAnnotationsName, $currAnnotationsValue := $root.Values.ingressAdditionalAnnotationsOptions -}}
        {{ if eq (tpl $currAnnotationsName $root) $AdditionalAnnotationsName }}{{toYaml $currAnnotationsValue}}     
        {{ end -}}
    {{- end }}    
{{- end }}


{{- define "radcom.NginxIngressAnnotations" -}}
annotations:
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/configuration-snippet: |
        {{ .rewrite }}
    nginx.ingress.kubernetes.io/proxy-body-size: {{ .Values.max_file_upload_size }}
    nginx.ingress.kubernetes.io/proxy-connect-timeout: "300"
    nginx.ingress.kubernetes.io/proxy-next-upstream-timeout: "300"
    nginx.ingress.kubernetes.io/proxy-read-timeout: "300"
    nginx.ingress.kubernetes.io/proxy-send-timeout: "300"
    nginx.org/client-max-body-size: {{ .Values.max_file_upload_size }}
    {{- if .Values.authentication_enabled }}
    nginx.ingress.kubernetes.io/auth-response-headers: iv-user, iv-groups, iv-remote-address
    nginx.ingress.kubernetes.io/auth-signin: https://$host/authenticationms/?link=https://$host/guardian/portal
    nginx.ingress.kubernetes.io/auth-snippet: |
        proxy_set_header iv-remote-address $remote_addr;
        proxy_set_header X-Real-IP $remote_addr;
        if ($http_cookie ~* "jwt=([^;]+)(?:;|$)") {
            set $token "$1";
        }
        proxy_set_header jwt $token;
    nginx.ingress.kubernetes.io/auth-url: http://authenticationms-srv.production.svc.cluster.local/api/v1/Authentication/authenticateToken
    {{- end }}
{{- end -}}
