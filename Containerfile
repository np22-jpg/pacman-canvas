FROM  quay.io/sclorg/nodejs-20-c9s@sha256:81d953c46168606268188c00ec241fec65ee7fe7dfa5ce2c524f91e73c2d169c AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:1df1c5ac4447f075a88074367790ff660f5895c3ad91ba6dc59e0a39c8d035c6 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]