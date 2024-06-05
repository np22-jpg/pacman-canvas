FROM  quay.io/sclorg/nodejs-20-c9s@sha256:17107c46368dc33615ee2e360616da827934210304ceed4180a1a8e597beff71 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:9ec04fd8c152b734627b13d46687251854afa0afc0ef98dea9cfd34f2b1cf5ad AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]