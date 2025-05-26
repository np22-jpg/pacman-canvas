FROM  quay.io/sclorg/nodejs-20-c9s@sha256:605d2477a7d7004f2a1a18581ac913515170d5ccb689e83fdc8655304c3e643a AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:d550bb54be02a6d107f0a548fecba6bcc09e58db6e814e348e50a8de975c2c62 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]