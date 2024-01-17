FROM  quay.io/sclorg/nodejs-20-c9s@sha256:1655e12813667062152b4ac0cf36c6a46a482833b6e24ce4f80cda1c505bf03d AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:93d6f3f6b9108f71a36adcb5dc4a0118415a59a205ccbe6372dba2f9d0d89c72 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]