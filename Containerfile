FROM  quay.io/sclorg/nodejs-20-c9s@sha256:7665661493254f2cb1a8a0082433bea0531ac57a0552a1b558a8a1fc500be19a AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:a1b68c8526adc134ff785c5781060495dc7b02d6f97dac375c6184a7c1f0fa10 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]