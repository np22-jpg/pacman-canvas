FROM  quay.io/sclorg/nodejs-20-c9s@sha256:b672069eefe162733706250390c528650549c2bcb998e0d9c37e9036c364cbf4 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:4c8b0d5f7545f483eb6847353f8c341952b289772a4f70b8d785fead0c0a8c5f AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]