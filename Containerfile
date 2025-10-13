FROM  quay.io/sclorg/nodejs-20-c9s@sha256:e6d5189ad6fad58edb0ef73ef641de75a9f4b3b08298d1687bfe1c0d3e4c0b52 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:2d965c484f294bf8906a809f40c3a150b85b62425c50e1ab2f9ac0b9f69d7459 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]