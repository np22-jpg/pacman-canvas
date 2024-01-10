FROM  quay.io/sclorg/nodejs-20-c9s@sha256:ce2b71bba387f87b64cba89abe5ecac1ae9b75e0f515f40cd87521706501fad1 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:ad8e9c2786d970802e9bd84eebc4f60eba079db39bc26605944e27d2286741ad AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]