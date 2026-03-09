FROM  quay.io/sclorg/nodejs-20-c9s@sha256:70dbeef0f734525e7158905cea0ae43a29d79cee8971f25451d6a6b83601c7e7 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:754b2f6e532e0ea2912f591ae1beece974e4c238fef8093dce44f05177d85915 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]