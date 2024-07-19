FROM  quay.io/sclorg/nodejs-20-c9s@sha256:0264a897b0e5d606dbb18ff1cbac256dbb96039ab3a776c0a639904f987cfa73 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:85ec3fcb9a0aba1dc4cd83c41ba635b396de3110ec6b7a720b9aa957fab8fdab AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]