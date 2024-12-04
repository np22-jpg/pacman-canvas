FROM  quay.io/sclorg/nodejs-20-c9s@sha256:dee4e3553c8b872a8ff0497b9742bf8e3cf80c8485510d0c6ed1579008cca34f AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:8e52b82ea1fc10b8c463e16e94c90070e6751cae0e1d56307bfb1b091a756364 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]