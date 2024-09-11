FROM  quay.io/sclorg/nodejs-20-c9s@sha256:0f387514f00af0ac08f4281a7a1457623dbb3533d50eee7451ec928347df476c AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:b27fe132c1ba894284704ea8952536e54a80ff2848ff411fc62a982dd2784234 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]