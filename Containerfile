FROM  quay.io/sclorg/nodejs-20-c9s@sha256:e21fde8279d4e34b3e4bf1a9e62b869119d8bf01004a73b00836ade36f98dafe AS build

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