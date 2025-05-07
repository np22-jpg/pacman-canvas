FROM  quay.io/sclorg/nodejs-20-c9s@sha256:107c72e07b8f9b997ebbbd1dc180610b099c40dd51241d587b593588049cca00 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:5b345ba3009bb41c85fe16b59fe5dd175e41ab960bddc63398016497286bccd3 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]