FROM  quay.io/sclorg/nodejs-20-c9s@sha256:315be78a50484d0338d90e4ca5b6b5afee0d13a484db8cf83fa60f31e3885e22 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:a7a5d10fd9552ab81a6663b95c366fa2cf0e9391845f22d10f93454a8f858afe AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]