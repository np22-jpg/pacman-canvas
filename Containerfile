FROM  quay.io/sclorg/nodejs-20-c9s@sha256:df348e727c460fa6e8a136e0638a64036253beb1a490b8023bb5349a095bb22e AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:4cd7b9904ee57ca8144f171bcf25a756e67d8f12cf603a8ade7aff1646b62d74 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]