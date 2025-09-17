FROM  quay.io/sclorg/nodejs-20-c9s@sha256:dd6417ac9e930ad4d440a158c2bd7e3d043af63a50fcd0a9ae173aaf332769c1 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:68c9d279c6226b12fa804ee0350740fbe1c60412bb59e7fd932beb9a9d64752e AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]