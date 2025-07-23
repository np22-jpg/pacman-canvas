FROM  quay.io/sclorg/nodejs-20-c9s@sha256:9f3bb6b0b5377eef1b410401b23db08e187ccef8f00d45aef23efef4364d8716 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:8520d92f6f65edd00fe7342d5f809e83e5580c4a79ecd12b3219ed091c3d6c9d AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]