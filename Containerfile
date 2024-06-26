FROM  quay.io/sclorg/nodejs-20-c9s@sha256:9bedd7cb574aa557755a2435ecf0bd15c093af40b1138afcf7dd53d9be0ae13c AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:0c067787796d26204cc2357678223ba8eaac68cae1abb947b0a37c3e11f241b0 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]