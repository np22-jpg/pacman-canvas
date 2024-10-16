FROM  quay.io/sclorg/nodejs-20-c9s@sha256:b672069eefe162733706250390c528650549c2bcb998e0d9c37e9036c364cbf4 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:c6cc856b03007d1e2d36cc0dc2100ed3b4f045892a557f6f9500ebc49f851d87 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]