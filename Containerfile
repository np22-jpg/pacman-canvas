FROM  quay.io/sclorg/nodejs-20-c9s@sha256:60dc5b48884980386bf8b54f9ab4633a7953f60506467e4bd614ba8ecf2c33b5 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:920d7b43fcd0111717dd6ed42dc667a5ee4c17a8bd1cc99b0136603156015da1 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]