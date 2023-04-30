{{/*
Expand the name of the chart.
*/}}
{{- define "chefbook-certificates.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "chefbook-certificates.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "chefbook-certificates.labels" -}}
helm.sh/chart: {{ include "chefbook-certificates.chart" . }}
{{ include "chefbook-certificates.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/component: certificates
app.kubernetes.io/part-of: cluster
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "chefbook-certificates.selectorLabels" -}}
app.kubernetes.io/name: {{ .Values.issuer.name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Choose Let's Encrypt server
*/}}
{{- define "chefbook-certificates.server" -}}
{{- if .Values.issuer.server.staging }}
{{- print "https://acme-staging-v02.api.letsencrypt.org/directory" }}
{{- else }}
{{- print "https://acme-v02.api.letsencrypt.org/directory" }}
{{- end }}
{{- end }}
