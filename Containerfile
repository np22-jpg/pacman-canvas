FROM  quay.io/sclorg/nodejs-20-c9s@sha256:8fff5ef50d22f52d656ebcecf51bb6b5bbeab26bf832da41d5a2f841362f3a47 AS build

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