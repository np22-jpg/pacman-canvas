FROM  quay.io/sclorg/nodejs-20-c9s@sha256:b80662fedaf691096f45ee4d59fe136d482d10d3612e6ee6b7d23981710830d1 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:edb9a38ceaec7b7a4a7e5e488e9837648e32f9c3cc897061bc044a6fc8c4fd1d AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]