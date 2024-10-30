FROM  quay.io/sclorg/nodejs-20-c9s@sha256:5c129be6a92681172d0714910f9f1ab4f609d9a026f1a759e4770b3ed92e69f9 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:871e83b1652da4f69258ec9670a32ecc4290318a6ab58e178c32b159435c53a0 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]