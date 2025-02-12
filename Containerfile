FROM  quay.io/sclorg/nodejs-20-c9s@sha256:a2a5c0e89f5d1dbff5d6aac8f0270ffd49a8e7578d13a8cc2fb3a689b9081006 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:7535c192baf6b73bf14fb9bff48adbc066025ddcdbdd254cd59d642d4ad48984 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]