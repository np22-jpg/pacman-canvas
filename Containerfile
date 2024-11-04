FROM  quay.io/sclorg/nodejs-20-c9s@sha256:127fec1a2dc6f8888c4dd3e968b6ed1614d8cca88dd829b7d3314aa9cd493553 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:9066101956fb634df38599c16717a5b44ce37a298bfd754eb5284c306ac10e3e AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]