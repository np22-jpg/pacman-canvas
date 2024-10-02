FROM  quay.io/sclorg/nodejs-20-c9s@sha256:21e118f6dccc6339d35dcf9b60ef66a4c2c95c1ab9685f725204f7ff6e3c522c AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:e2ecde9d356189e676038fe5dfd86a82292f0b678d0fa3da78b964a7c78d732e AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]