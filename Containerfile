FROM  quay.io/sclorg/nodejs-20-c9s@sha256:4df3f1743485a3e6a9f9b226a49954dd6c88bc20af173073f976868642b24b18 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:e6c89c25079184a5d12c127589153828c1a0c29b9ed65795cc6e0cd2f992d220 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]