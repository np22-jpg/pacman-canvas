FROM  quay.io/sclorg/nodejs-20-c9s@sha256:264c611458f9afa10aa7f31c2dc22077658e29172fbe4b3136c087f913cb6a1e AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:100ff3c79914b5703aec15cc06596fbb2c3b6fd4016161c67e0a7b41dc77d398 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]