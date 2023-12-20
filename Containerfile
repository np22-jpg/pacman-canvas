FROM  quay.io/sclorg/nodejs-20-c9s@sha256:7acf26882816637c73cafd70bec1271091abfbe2037300379fd21a5959d87826 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:68cbb7777dd2bffd41c67f7204c707370590c43b6a60fc3980cc10a0518f2de3 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]