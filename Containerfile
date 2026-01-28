FROM  quay.io/sclorg/nodejs-20-c9s@sha256:a192c60d3d8bf54c8becb4df30a784852a20a12779d1abca76843675e15af6f0 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:1aad7ecb5f48fd926d45d252f472243224135a2108b0a9b995f9bb4ba5991d17 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]