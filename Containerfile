FROM  quay.io/sclorg/nodejs-20-c9s@sha256:cbd2bd9e061c15dcda83671abb7db567bd8dfabd516e2a5c04c38ce5e867bfd9 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:030381df57771359119a8b6d28d713ffacfcd417fa09d67d0417f13b2a1a27fa AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]