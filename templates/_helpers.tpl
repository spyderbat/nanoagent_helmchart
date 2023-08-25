{{/*
Expand the name of the chart.
*/}}
{{- define "nanoagent.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "nanoagent.fullname" -}}
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
{{- define "nanoagent.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "spyderbat.version" -}}
spyderbatchart: {{ include "nanoagent.chart" . }}
{{- end }}


{{- define "spyderbatenv.version" -}}
- name: SPYDERBATCHART
  value: {{ include "nanoagent.chart" . }}
{{- end }}


{{/*
Common labels
*/}}
{{- define "nanoagent.labels" -}}
helm.sh/chart: {{ include "nanoagent.chart" . }}
spyderbatchart: {{ include "nanoagent.chart" . }}
{{ include "nanoagent.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "nanoagent.selectorLabels" -}}
app.kubernetes.io/name: {{ include "nanoagent.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "nanoagent.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "nanoagent.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}




