FROM  quay.io/sclorg/nodejs-20-c9s@sha256:b44e82ba241fccaadf1205bb71881c2c5936f9cc27ba555b332924e5bb3cce66 AS build

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