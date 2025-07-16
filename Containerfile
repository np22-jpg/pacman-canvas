FROM  quay.io/sclorg/nodejs-20-c9s@sha256:5b3e8ceab22b8f77269ce4fc243f77bb04398210dec16f0e4af1821498cdd316 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:e0321c8b2b18fab085c55ddbffdcb343e2773f8b3fd4aee4a6ab11285f873b12 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]