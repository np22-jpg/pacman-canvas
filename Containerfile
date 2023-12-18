FROM  quay.io/sclorg/nodejs-20-c9s@sha256:e63279b01fa149cfeb05cd3f49bf558df8a641bbeab1c3fc3b1c17425711ce68 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:422150b7f79de120d2fb62c131d5ff181274fbb1f45620f07aa174d12a6c0819 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]