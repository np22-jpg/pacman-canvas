FROM  quay.io/sclorg/nodejs-20-c9s@sha256:533f27b25798e0eee55f850d3c733b83b190a396389845289df96ede1ea81237 AS build

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