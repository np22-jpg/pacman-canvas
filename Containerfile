FROM  quay.io/sclorg/nodejs-20-c9s@sha256:a70079ea3b9cb4cdbcec0655fc96765dd8c2cd6dd2d0a0b3ad206487ded1a943 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:8d1b2fc82ebb54f18f6b2f065796dfb7fb1e73f8e845848689a0d294e7f97af9 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]