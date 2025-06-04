FROM  quay.io/sclorg/nodejs-20-c9s@sha256:4f1da5d46ae3c87ad2a0355a1e4b2f20c47e4af3bca28c4bc62b638827bd6117 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:2ef05edf4954b55412997d293637a100997b33247a5e62ac45fe300c21007b14 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]