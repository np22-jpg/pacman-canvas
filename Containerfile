FROM  quay.io/sclorg/nodejs-20-c9s@sha256:a3a7d2953a29262cc3d6ed9ff18eb4983067985636c7f21b179e95b063e923ef AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:7295d5bce3a2765466f5c156fcf2fdb8d9280c3f79f2cdd38bd8801b713659c2 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]