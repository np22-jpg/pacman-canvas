FROM  quay.io/sclorg/nodejs-20-c9s@sha256:2c5da3ff073cedc6926c06c91e4e722fb6cc0a35f1764959c5987334f67a2fd8 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:d753d24b6b29418f4b3c1ccb352094835a7c8b28cc6f6225c929ec66cc99b86b AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]