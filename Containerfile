FROM  quay.io/sclorg/nodejs-20-c9s@sha256:dd94e4937b7d47368f6078a5e1285990de6f85eac9c71e6be224871614dbeaf3 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:6f434a255018798feb44bfeb8610e2792155c597979d2f624a7de8b669ca65ea AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]