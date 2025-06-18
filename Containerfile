FROM  quay.io/sclorg/nodejs-20-c9s@sha256:9b0de4666ea8c0fc3da88eb23f97a75474d0b72540e894653490336e150a1110 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:5d2e2ec99324417288d5fde7c0b047804ab874785343be8be1934b49b247cae7 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]