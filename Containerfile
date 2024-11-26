FROM  quay.io/sclorg/nodejs-20-c9s@sha256:4b6e4919a58eb2fa4bbcca5c42edb0df54e37eec04048bcf8f43a840c5fde947 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:d6bffc83cb9487954b8bfa34b3305d7cfe60c5d2af9297f90deaad9a04bf5dbb AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]