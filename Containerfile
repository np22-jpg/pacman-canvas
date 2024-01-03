FROM  quay.io/sclorg/nodejs-20-c9s@sha256:2265fa4dd7ad4f35d48c3a3a697d0ebb9bd64d96397b9d0e2a79f84b27ec8ab3 AS build

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