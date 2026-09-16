FROM  quay.io/sclorg/nodejs-20-c9s@sha256:a40601e7c1842e8fbac734ef478c1a768742f259a1f1ced3f12be6a560f26cfe AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:f9e5cee00f11992e0d1f27848e668fd2e8c4970b4a3eadeaa42098fbd4e5b5ef AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]