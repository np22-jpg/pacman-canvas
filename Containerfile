FROM  quay.io/sclorg/nodejs-20-c9s@sha256:52d38889d907c5d9aabe8e86dec06b11685b6e59799091a5459e566b1f0ecf27 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:6889fea6a14c9cd71444c8e68f2fd02bf2d69e9992c2ea3494ff571cb3cc6988 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]