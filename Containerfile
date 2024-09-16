FROM  quay.io/sclorg/nodejs-20-c9s@sha256:820f3545d2816ea479cbe5cbab31ea7fe56f7c056de2372dcf34eb94001848c8 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:23e24667ad04be33641bae84888b83c1b4d813bc92eabaf7b7a2517bafc547e9 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]