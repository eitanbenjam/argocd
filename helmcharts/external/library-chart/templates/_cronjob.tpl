{{- define "library-chart.cronjob" -}}
{{- $cronjob := .Values.libraryChart.cronjob -}}
apiVersion: batch/v1
kind: CronJob
metadata:
  name: {{ $cronjob.name | default .Chart.Name | quote }}
  labels:
    {{- include "library-chart.labels" . | nindent 4 }}
spec:
  schedule: "{{ $cronjob.schedule }}"
  successfulJobsHistoryLimit: {{ $cronjob.successfulJobsHistoryLimit | default 1 }}
  jobTemplate:
    spec:
      template:
        spec:
          containers:
            - name: {{ $cronjob.containerName | default .Chart.Name }}
              image: "{{ $cronjob.image.name }}:{{ $cronjob.image.tag }}"
              {{- if $cronjob.env }}
              env:
                {{- toYaml $cronjob.env | nindent 16 }}
              {{- end }}
              {{- if $cronjob.command }}
              command: {{ $cronjob.command | default (list "/bin/sh" "-c" "echo 'No command specified'") | toYaml | nindent 16 }}
              {{- end }}
              {{- if $cronjob.args }}
              args: {{ $cronjob.args | toYaml | nindent 16 }}
              {{- end }}
              {{- if $cronjob.volumeMounts }}
              volumeMounts:
                {{- toYaml $cronjob.volumeMounts | nindent 16 }}
              {{- end }}
              {{- if $cronjob.resources }}
              resources:
                {{- toYaml $cronjob.resources | nindent 16 }}
              {{- end }}
          restartPolicy: {{ $cronjob.restartPolicy | default "OnFailure" }}
          {{- if $cronjob.volumes }}
          volumes:
            {{- toYaml $cronjob.volumes | nindent 16 }}
          {{- end }}
{{- end }}
