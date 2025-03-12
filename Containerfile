FROM  quay.io/sclorg/nodejs-20-c9s@sha256:caa017f84aeb7235c12395fe76728222b38116e783ad1b1e0c75e5b51b21e8e0 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:f913d815f88a87a497010dcfefb69628ee520561e9929e1f95d26316e1109c4b AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]