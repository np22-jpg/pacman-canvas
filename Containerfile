FROM  quay.io/sclorg/nodejs-20-c9s@sha256:9f3bb6b0b5377eef1b410401b23db08e187ccef8f00d45aef23efef4364d8716 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:1982e2d64f67e6fa1397a3447c9175247507e5f7d2e146eb84aba64b2437da89 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]