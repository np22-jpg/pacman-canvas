FROM  quay.io/sclorg/nodejs-20-c9s@sha256:bda5633dc70e6830b0d8c18bf549a9c9750841767725a447e485fc8861150778 AS build

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