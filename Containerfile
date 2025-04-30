FROM  quay.io/sclorg/nodejs-20-c9s@sha256:ee2b30f2b90d5abad8b531522e2dd0269517c0c5bd354e11f4b27198a4acec8c AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:cf474b7245bd33e2131f93753c8d8d2cc5927a7c8aa2e00c8efe81bbf6491a2d AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]