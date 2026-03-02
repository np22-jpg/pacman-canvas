FROM  quay.io/sclorg/nodejs-20-c9s@sha256:f7e82bb749b83f28a5e856f32c56906f0534bfb0a372da61b8761900ced06668 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:f391cfc762528b511752df612eb91324962e6d4d9851973371b2367219bec0f7 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]