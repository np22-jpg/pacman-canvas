FROM  quay.io/sclorg/nodejs-20-c9s@sha256:b92d9d7617496288676478e8a487126f50e3a6cf3da989e2e0e3c38edb4aa80e AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:208e5275542302ffdbe855d8a9a9f2c669a3018eafed29d734d293a2074d7fc8 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]