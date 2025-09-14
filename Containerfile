FROM  quay.io/sclorg/nodejs-20-c9s@sha256:b5df17a9c3def1f63ef84f7c41b435c0ebd6df96134c4107eb58ba09bf514060 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:1d894a8f53060e5d5682826617ab4332f6ce507b385915f297aab1e56846487a AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]