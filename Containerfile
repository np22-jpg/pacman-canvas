FROM  quay.io/sclorg/nodejs-20-c9s@sha256:3d0e3f7eb7e2ec39194e19b7443abe5e2c0e39f20fa7eb76a03c33c9e5a23bc5 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:f6a967f9dfd992e81abac716b208fe99f5bfdc74a228b49606ec10df15f09c54 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]