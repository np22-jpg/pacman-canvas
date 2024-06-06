FROM  quay.io/sclorg/nodejs-20-c9s@sha256:33239ba2c817e2488824567d4cff43db17007811c01ee6e3742e939af730e0f3 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:e5162b83e76fd81f522b459e0921e1cd0693854935ec9394be3f4a4d4bd34a5a AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]