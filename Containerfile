FROM  quay.io/sclorg/nodejs-20-c9s@sha256:fec0423e08e519abccc57eb9262e99ca8c7a6810a917935ab5e7a9df4291c270 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:e966074c927d3b547d59fbf980456e9e7981ac2425e2334d307fe0faa180d1a0 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]