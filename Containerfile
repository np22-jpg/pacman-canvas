FROM  quay.io/sclorg/nodejs-20-c9s@sha256:7f09362c1715a23c1b831afe7aa25fbb48b186745f58abaca605694e0d0c2aae AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:8cdb00430a0b1dc5667ae1673665d41c219b220bcab9a0ef1985a167ea053064 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]