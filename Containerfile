FROM  quay.io/sclorg/nodejs-20-c9s@sha256:9b0de4666ea8c0fc3da88eb23f97a75474d0b72540e894653490336e150a1110 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:8c0d73287dd2ebf8ad8a6d8d2aefa04996ea111bf7161b5968055ea7d047b682 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]