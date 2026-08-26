FROM  quay.io/sclorg/nodejs-20-c9s@sha256:d47b375cd48b6febe6afe43d32f63e01f61ee9f327896de4dff4936d0ef9876a AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:26c2f0729c52e053a3cb8935213179ca287b56dd448965bcd4272c75c92201d6 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]