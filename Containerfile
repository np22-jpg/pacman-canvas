FROM  quay.io/sclorg/nodejs-20-c9s@sha256:caa017f84aeb7235c12395fe76728222b38116e783ad1b1e0c75e5b51b21e8e0 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:b08769394203549c0d489932070db4c55f2f3ab33b667b0fa107db036a57605e AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]