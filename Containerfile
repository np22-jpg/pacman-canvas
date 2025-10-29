FROM  quay.io/sclorg/nodejs-20-c9s@sha256:4fb4597023510d4392b73cbe94964754cf7e16e05301cbd62e773b95e4c07dd1 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:100ff3c79914b5703aec15cc06596fbb2c3b6fd4016161c67e0a7b41dc77d398 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]