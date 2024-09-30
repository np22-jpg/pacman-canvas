FROM  quay.io/sclorg/nodejs-20-c9s@sha256:4d9b6986ee979bc7e693cd7ecc091efec9e532275d7fad938965b7672473b94e AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:2c4bfac6dfd0a910296ed4a6390368ec7fcbb2b51c66a37fc31311972069725d AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]