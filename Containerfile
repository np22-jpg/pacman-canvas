FROM  quay.io/sclorg/nodejs-20-c9s@sha256:a1ab7d138cf07231e0e14a5ff44f3625dfa06ad02d4e3c267320afe00972c43b AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:af5ac6a1bb6eabde3b8e2bcf447fec535904935474300cb9ab0f048d371506c2 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]