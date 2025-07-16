FROM  quay.io/sclorg/nodejs-20-c9s@sha256:5b3e8ceab22b8f77269ce4fc243f77bb04398210dec16f0e4af1821498cdd316 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:ca512750fc78418eca799b285d8c9f7845b4a96f130dae8a4bb1f68003062186 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]