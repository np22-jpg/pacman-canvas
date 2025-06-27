FROM  quay.io/sclorg/nodejs-20-c9s@sha256:140d818af503783b953dc0b5a564c708c079d717021b1ac1d8f5e7a0f8f4740b AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:21dd3159e3642555337f741a96b7a030e54a4649c1582ea2aeb4d12174f46d7c AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]