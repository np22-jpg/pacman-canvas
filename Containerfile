FROM  quay.io/sclorg/nodejs-20-c9s@sha256:abea11971eb86a9aee33c69fd7edf949d576bf6a4321695896dc012dc5fc3362 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:ca512750fc78418eca799b285d8c9f7845b4a96f130dae8a4bb1f68003062186 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]