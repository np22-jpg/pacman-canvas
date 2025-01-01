FROM  quay.io/sclorg/nodejs-20-c9s@sha256:43c10d280399c0b8b7fe8c23977693fa2427bd4cba92ce158bbd77f2556b93fd AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:81a94bbccd40beaaf6b2709f600c0c111337e0af1973024b6f64bfba7e22cf37 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]