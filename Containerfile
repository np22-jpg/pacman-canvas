FROM  quay.io/sclorg/nodejs-20-c9s@sha256:a3a7d2953a29262cc3d6ed9ff18eb4983067985636c7f21b179e95b063e923ef AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:33c8aea67f99fa2adb9e00694ec1f3c2c9122e13ac442beb746c44cd61068bb9 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]