FROM  quay.io/sclorg/nodejs-20-c9s@sha256:1208aefe39d48ad0b29ed83c9c2ef6ec6718ba4386d0b6556b12e3ace9ac1eed AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:3c9bd704dcfdd872b0dca9f71355e90f57406129ec9eacddb3449f8685aee90a AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]