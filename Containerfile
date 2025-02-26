FROM  quay.io/sclorg/nodejs-20-c9s@sha256:0f8a4a1aa343029842423c202d728e7b2064df164b94c80095fea36e851100e5 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:7535c192baf6b73bf14fb9bff48adbc066025ddcdbdd254cd59d642d4ad48984 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]