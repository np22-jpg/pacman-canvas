FROM  quay.io/sclorg/nodejs-20-c9s@sha256:c6933057a2f6aa7f93a01629c6628d3d411a79ab0ea913046fccc36ff688087d AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:22ab8f664ce7139b704cab7ae392bc79efb2ca6b057949be66e3589d68d583d8 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]