FROM  quay.io/sclorg/nodejs-20-c9s@sha256:9ff84fb6eb5322f1562dd915cffa3123013755208e30117a96654824967e4c4c AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:9d7515bc754e4602aabd37c0c20cc166b0badc8af0a0215deddfbeed512ef4ad AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]