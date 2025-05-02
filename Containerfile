FROM  quay.io/sclorg/nodejs-20-c9s@sha256:fcf0b5ce281fe5e5755049dbb08e3912853e95f2f80327771a27b7459957b4f4 AS build

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