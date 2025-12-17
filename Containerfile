FROM  quay.io/sclorg/nodejs-20-c9s@sha256:bac616dab4209f8107d16fe84ec1ddf7c112d744a78fbc8c870c4794f50a8dec AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:4a6e32ca4fca2b578d2db7885a3b999dd710232b7d2aabe5f90216b53990290a AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]