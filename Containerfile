FROM  quay.io/sclorg/nodejs-20-c9s@sha256:2b473a7c7fab09519c3b8295775f01c9f3141956f35b3ca9f91936c8a6082052 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:cf474b7245bd33e2131f93753c8d8d2cc5927a7c8aa2e00c8efe81bbf6491a2d AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]