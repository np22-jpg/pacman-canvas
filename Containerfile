FROM  quay.io/sclorg/nodejs-20-c9s@sha256:aba7437faf029282f93a169f868dd684f0ecf9ca20004a12820637ec2c6f2280 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:f75a586744e52b20db3e21c040ec966a7a825625717a26f0ec33ac21a151b03d AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]