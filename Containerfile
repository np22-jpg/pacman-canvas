FROM  quay.io/sclorg/nodejs-20-c9s@sha256:3d86e7aea718fcbaf38a4a16b9b95437a1bb679211791a99dee1a9ee72d4aa88 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:d4cb7c8b51f87b49efb0f5b7adfd53b5c8a27fafd1dfc8cc862b10fc26126760 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]