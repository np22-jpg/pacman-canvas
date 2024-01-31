FROM  quay.io/sclorg/nodejs-20-c9s@sha256:8af4269c30b5be7a9b33de0b6bf02de0f42fdecc68d6625702b9ea91467142c4 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:884220e554218b4f88d42ec1f1fd86d91a13ad6d6f7d7a532be51058c7f02061 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]