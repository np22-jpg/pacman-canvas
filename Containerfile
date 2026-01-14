FROM  quay.io/sclorg/nodejs-20-c9s@sha256:e5f55a3ef23f0d13503a9826414f833921c6573e429c17eab1b3e024e88211da AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:f14fc7c51985b8ba06f5c12c1cc61e6d95168def08505e6d9328b1c121badc28 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]