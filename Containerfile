FROM  quay.io/sclorg/nodejs-20-c9s@sha256:55b747901a5f99d8d96b381009d159902022767214c8217e3ff3c685793a7cab AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:46e6b8cc5534693fd9c4a4a29572624778217ef04bb6706a2d6e6ff2852e1f80 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]