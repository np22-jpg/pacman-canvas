FROM  quay.io/sclorg/nodejs-20-c9s@sha256:6c50f47d3e4ab3609c0be75e4f97c91cb8aabc7190e6e513f39255a91915f062 AS build

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