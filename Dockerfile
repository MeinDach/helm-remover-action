FROM gcr.io/cloud-builders/kubectl
LABEL "maintainer"="Stefan Maier <stefan@datalove.io>"
LABEL "com.github.actions.name"="PR Closer"
LABEL "com.github.actions.description"="After closing / merging PR remove helm chart"
LABEL "com.github.actions.icon"="activity"
LABEL "com.github.actions.color"="red"

ENV KUBECTL_VERSION="v1.10.11"
ENV HELM_VERSION="v2.10.0"

RUN curl -Lo /tmp/helm-linux-amd64.tar.gz https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz \
    && tar -xvf /tmp/helm-linux-amd64.tar.gz -C /tmp/ \
    && chmod +x /tmp/linux-amd64/helm && mv /tmp/linux-amd64/helm /usr/local/bin/ \
    && helm init --client-only \
    && helm plugin install https://github.com/mbenabda/helm-local-chart-version

COPY jq /usr/bin/jq
COPY helm-remover-action /usr/bin/helm-remover-action

ENTRYPOINT ["helm-remover-action"]