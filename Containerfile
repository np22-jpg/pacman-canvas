FROM  quay.io/sclorg/nodejs-20-c9s@sha256:d27ea23904c46cee8a6b2d571ae9d4e8bfce12b01befa5c5e5134d69ecaaf8d0 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:4bd349d7cba7e2221575499253c877b1b855d52dd9a13cd8b8fe07b57d3967b2 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]