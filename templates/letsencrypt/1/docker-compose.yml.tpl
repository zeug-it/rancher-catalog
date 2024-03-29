version: '2'
services:
  letsencrypt:
    image: vxcontrol/rancher-letsencrypt:v1.0.0
    environment:
      EULA: "${EULA}"
      API_VERSION: "${API_VERSION}"
      CERT_NAME: "${CERT_NAME}"
      EMAIL: "${EMAIL}"
      DOMAINS: "${DOMAINS}"
      PUBLIC_KEY_TYPE: "${PUBLIC_KEY_TYPE}"
      RENEWAL_TIME: "${RENEWAL_TIME}"
      PROVIDER: "${PROVIDER}"
      DNS_RESOLVERS: "${DNS_RESOLVERS}"
      RENEWAL_PERIOD_DAYS: "${RENEWAL_PERIOD_DAYS}"
      RUN_ONCE: "${RUN_ONCE}"
      CLOUDFLARE_EMAIL: "${CLOUDFLARE_EMAIL}"
      CLOUDFLARE_KEY: "${CLOUDFLARE_KEY}"
      DO_ACCESS_TOKEN: "${DO_ACCESS_TOKEN}"
      AWS_ACCESS_KEY: "${AWS_ACCESS_KEY}"
      AWS_SECRET_KEY: "${AWS_SECRET_KEY}"
      DNSIMPLE_EMAIL: "${DNSIMPLE_EMAIL}"
      DNSIMPLE_KEY: "${DNSIMPLE_KEY}"
      DYN_CUSTOMER_NAME: "${DYN_CUSTOMER_NAME}"
      DYN_USER_NAME: "${DYN_USER_NAME}"
      DYN_PASSWORD: "${DYN_PASSWORD}"
      VULTR_API_KEY: "${VULTR_API_KEY}"
      OVH_APPLICATION_KEY: "${OVH_APPLICATION_KEY}"
      OVH_APPLICATION_SECRET: "${OVH_APPLICATION_SECRET}"
      OVH_CONSUMER_KEY: "${OVH_CONSUMER_KEY}"
      GANDI_API_KEY: "${GANDI_API_KEY}"
      AZURE_CLIENT_ID: "${AZURE_CLIENT_ID}"
      AZURE_CLIENT_SECRET: "${AZURE_CLIENT_SECRET}"
      AZURE_SUBSCRIPTION_ID: "${AZURE_SUBSCRIPTION_ID}"
      AZURE_TENANT_ID: "${AZURE_TENANT_ID}"
      AZURE_RESOURCE_GROUP: "${AZURE_RESOURCE_GROUP}"
      AURORA_USER_ID: "${AURORA_USER_ID}"
      AURORA_KEY: "${AURORA_KEY}"
      AURORA_ENDPOINT: "${AURORA_ENDPOINT}"
      NS1_API_KEY: "${NS1_API_KEY}"
    volumes:
      - /var/lib/rancher:/var/lib/rancher
      {{- if .Values.VOLUME_NAME}}
      - {{.Values.VOLUME_NAME}}:/etc/letsencrypt
      {{- end }}
    labels:
      io.rancher.container.create_agent: "true"
      io.rancher.container.agent.role: "environment"
      {{- if eq .Values.RUN_ONCE "true" }}
      io.rancher.container.start_once: "true"
      {{- end }}
      {{- if .Values.SC_LABEL_VALUE }}
      io.rancher.scheduler.affinity:host_label: ${SC_LABEL_VALUE}
      {{- end }}
{{- if .Values.VOLUME_NAME}}
volumes:
  {{.Values.VOLUME_NAME}}:
    {{- if .Values.STORAGE_DRIVER}}
    driver: {{.Values.STORAGE_DRIVER}}
    {{- if .Values.STORAGE_DRIVER_OPT}}
    driver_opts:
      {{.Values.STORAGE_DRIVER_OPT}}
    {{- end }}
    {{- end }}
{{- end }}
