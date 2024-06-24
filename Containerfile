FROM  quay.io/sclorg/nodejs-20-c9s@sha256:a5be38d53ff1740b050464e0de646be0aab9a918505c45448d73e8a19924ea96 AS build

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