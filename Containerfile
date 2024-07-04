FROM  quay.io/sclorg/nodejs-20-c9s@sha256:fa3a415d34fc554ba2c34f9ebac004a15077359fb0bca1729642006ba3a58885 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:985e162262fcb13e3c801b24fb0000a1037ae6bdc88e56f2af6c84f4b3622422 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]