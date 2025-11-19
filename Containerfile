FROM  quay.io/sclorg/nodejs-20-c9s@sha256:a1ab7d138cf07231e0e14a5ff44f3625dfa06ad02d4e3c267320afe00972c43b AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:b5cef11bf1ea885dc62e89bf4e080865f7cc460a43107b798493e64e9a69a199 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]