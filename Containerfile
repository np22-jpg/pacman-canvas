FROM  quay.io/sclorg/nodejs-20-c9s@sha256:e6aaecff699edc535926e8eb88f9fbee9e964a6183a314e2af1c26d9448e40cc AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:ae0250d3497128b70caaf6f803be404bd170b25e665a668f5b32e379ed8432ab AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]