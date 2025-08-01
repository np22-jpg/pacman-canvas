FROM  quay.io/sclorg/nodejs-20-c9s@sha256:e47418b11a52dec976d2d4109416e1f1f92777b7cca6e3dc6e72d923cf7b9d9a AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:779e6e0936ffa5603dad7607eca810bcb8866e97e977e8ab4bdfcd5cba3fd354 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]