FROM  quay.io/sclorg/nodejs-20-c9s@sha256:bd11756fff3d0be8a4ce21e61389b5fbd9e7500f1c745747502010ed616ace71 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:3c9bd704dcfdd872b0dca9f71355e90f57406129ec9eacddb3449f8685aee90a AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]