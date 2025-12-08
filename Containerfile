FROM  quay.io/sclorg/nodejs-20-c9s@sha256:79d63156b491a9c9c274fe95c3d0a2ea79d494959ca7ec81c775035654ef2c58 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:6236c7281ef78d4e7e6ecab1299fea5ff1928bef236bd954153728c91fbb431d AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]