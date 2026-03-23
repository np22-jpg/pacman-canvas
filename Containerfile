FROM  quay.io/sclorg/nodejs-20-c9s@sha256:928a09fb9ed24fd8983f68fc667a645766793b1a7b61f215a7a36175dd57a657 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:1088e8680aefaf2fb7536f900f2695b45f8cbe0220b795cbb3ce9f5e955aa128 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]