FROM  quay.io/sclorg/nodejs-20-c9s@sha256:e945d83b85f19effe79ad32da58ab518f3e74e2740b70191b76c133f0a1eb9bf AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:9e799f5f59cd3adafb0356375cc536a4f3cc38c050c6d79a414a2af74d0fed2b AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]