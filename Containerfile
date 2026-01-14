FROM  quay.io/sclorg/nodejs-20-c9s@sha256:e5f55a3ef23f0d13503a9826414f833921c6573e429c17eab1b3e024e88211da AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:49835d1d25a62379746c96d39ccfc7ad1f7b9384f8c55554d9c5e121d20f2ce8 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]