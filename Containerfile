FROM  quay.io/sclorg/nodejs-20-c9s@sha256:21e118f6dccc6339d35dcf9b60ef66a4c2c95c1ab9685f725204f7ff6e3c522c AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:73cb8e3896fc1856aee090ed2642446fca26732fb9a801bdf129e23b1edbbe8a AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]