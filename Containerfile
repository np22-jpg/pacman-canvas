FROM  quay.io/sclorg/nodejs-20-c9s@sha256:c0b7c665d87264e8baf136a82b91f52e306e6ad0ba7d7cf7d50c66bc33b6d71b AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:637e8a0e120fcabe231590ad4da8e3f280c2dbf670416ed344b8658967ddfa4d AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]