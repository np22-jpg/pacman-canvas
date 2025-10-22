FROM  quay.io/sclorg/nodejs-20-c9s@sha256:cbd2bd9e061c15dcda83671abb7db567bd8dfabd516e2a5c04c38ce5e867bfd9 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:5a1dceca3bb9a1bb3001cf9e8a9ca2288f3ffce73795b0d1dfdf04360000d58e AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]