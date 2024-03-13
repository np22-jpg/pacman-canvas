FROM  quay.io/sclorg/nodejs-20-c9s@sha256:2115102e482971b7d95e65087859f1d7dbc506183f51254894b381a356b54e19 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:7eb95b82bb46f5f52b961df1f55e5d03bc496e2f1d32625f8c24a377609ae71e AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]