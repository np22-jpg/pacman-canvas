FROM  quay.io/sclorg/nodejs-20-c9s@sha256:3b0870b6de402f590a9c43d28954ad8fd0d814a0f6c57e3a1c865ad16eb1369b AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:63e9c97bf5219475ce88d8f3cf8291bb63e78fa6213b0f9a0634903813c2f2b8 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]