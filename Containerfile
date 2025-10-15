FROM  quay.io/sclorg/nodejs-20-c9s@sha256:25e94e96920b669218aca52bd7e5b8faf67f8eb8ec946f6d13a8626301e5da35 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:5a1dceca3bb9a1bb3001cf9e8a9ca2288f3ffce73795b0d1dfdf04360000d58e AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]