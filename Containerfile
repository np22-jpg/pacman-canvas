FROM  quay.io/sclorg/nodejs-20-c9s@sha256:b4356e77651f89db91cb88c3854e0c956d41cb798021f4b7d1aab1a492d19b26 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:9afdd544fe977115e3990f5c49844735a91b0abdcef66f8e8d631145be0f30d2 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]