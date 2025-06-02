FROM  quay.io/sclorg/nodejs-20-c9s@sha256:43a602d96d59954fa5204b5caa333bed96439fa021e0a0c7529858e3e54bc9d2 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:2ef05edf4954b55412997d293637a100997b33247a5e62ac45fe300c21007b14 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]