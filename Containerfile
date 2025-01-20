FROM  quay.io/sclorg/nodejs-20-c9s@sha256:c31b0f91def819bf41b0e77dd35b774287d3f6f8517131a02553159532723579 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:dead66228e15d5d50719603451e4e86fc531ead1d9f0a66efecdbd03283a6f99 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]