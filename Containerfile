FROM  quay.io/sclorg/nodejs-20-c9s@sha256:08f3d7b96f48b15e82e1ca39fa633df4d1c1689524330927e80f2cb34071e6a8 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:9fbcf841fd0e0cee7f5be3fd1bb6a9cb13846d48b0d39f5763a9a00c9fb9cc34 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]