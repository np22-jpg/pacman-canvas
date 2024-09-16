FROM  quay.io/sclorg/nodejs-20-c9s@sha256:820f3545d2816ea479cbe5cbab31ea7fe56f7c056de2372dcf34eb94001848c8 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:14fb58cb4bfc1f816b6a087639066f1b028f1a6ac068c3f152e707192792de15 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]