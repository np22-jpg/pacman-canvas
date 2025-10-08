FROM  quay.io/sclorg/nodejs-20-c9s@sha256:bbeb52cf485e35b7260a98dc66be6f1103f06558b31e4ee8e15647f8499331b9 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:f322457a516d02df6dca9b8649ac821eaf7e4c506f14ac1d0313564e01d622d1 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]