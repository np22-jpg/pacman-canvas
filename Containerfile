FROM  quay.io/sclorg/nodejs-20-c9s@sha256:8f89e051b35a9acef5f4b180a7ebf5921c7e51f9f6f3a9694551f7401ea77394 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:49fd6cf406cb153b701cf11f4c47b19ac2550fdd07767a941a3ea8b85ff6f107 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]