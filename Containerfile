FROM  quay.io/sclorg/nodejs-20-c9s@sha256:c6c0e84435201e26071caff0884659e794fc62b1b5b5bffecb62fcb2cd751603 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:308245ef26fb74e63513ebd23d58cfb79ae8cbad2da98d170260f1a80fa89af0 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]