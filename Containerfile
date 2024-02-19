FROM  quay.io/sclorg/nodejs-20-c9s@sha256:98a74d97e79f78c37cda453892aa00594a194a58a9c549de210aaf2d241e15d3 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:e1d8061aee0448b97da390bf5b7ecb1c46fce6a11e931cd2e46b6c6df874073d AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]