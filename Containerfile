FROM  quay.io/sclorg/nodejs-20-c9s@sha256:8cbca93953006464ba0d80845672faee741c09be327c4b519526c6361f128d86 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:88404c9f43d42c6bbcd3c9dd26f8400c4fc92a550cab85bcf9ec8256cc5458f0 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]