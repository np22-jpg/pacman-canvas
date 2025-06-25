FROM  quay.io/sclorg/nodejs-20-c9s@sha256:f7c48deadc2655b5d0e75b82bfca90c058d0dbc4e2587a88c5b99afebeaee381 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:1c55aa420c1a16ad22e9aca3edafe6a3f99ab3696baa7ca5eaf756836cb911ca AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]