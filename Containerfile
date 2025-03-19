FROM  quay.io/sclorg/nodejs-20-c9s@sha256:43c96f45799507db90d27a2fbd7bfe695ce15cb2b77b96ad30c7512ff56a6bf4 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:1a57cb82ec64fadb4ac2dc0e3506a2f3c8a08812cc6ec1a820b2fd6d52bc3cdb AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]