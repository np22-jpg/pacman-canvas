FROM  quay.io/sclorg/nodejs-20-c9s@sha256:55b747901a5f99d8d96b381009d159902022767214c8217e3ff3c685793a7cab AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:a7ca32f69fb13089e23d23ca1b989d8aade1b3c2e6639c75b52feee60dd12aff AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]