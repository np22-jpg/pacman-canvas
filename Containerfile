FROM  quay.io/sclorg/nodejs-20-c9s@sha256:923d52116dbd0ced0def024151a43dc18a217ab071364ae28cf65ba7b5fe617d AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:fb1261494e2e8f92b8d6d8c56246204b070015fe74affe08fa4dde4296781133 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]