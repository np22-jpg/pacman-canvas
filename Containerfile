FROM  quay.io/sclorg/nodejs-20-c9s@sha256:8ca4f074f83adeb7cfa6f2da8466f428f3479efcb94ae9eb00b242f9aa24e237 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:db982545531810d29b0bab9e50caaca4ba5bff0a7ff3576df1a855c8ea5b81dc AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]