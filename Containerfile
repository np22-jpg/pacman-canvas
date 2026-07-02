FROM  quay.io/sclorg/nodejs-20-c9s@sha256:530075841e1fe5353ff27fa6e5fac3b833767b3dfc03f9316db4246fa1b1e97e AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:9c15b45c58423b1097dd44af0ff7577af74d1530fb9c286d86c9404f5f9c85c2 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]