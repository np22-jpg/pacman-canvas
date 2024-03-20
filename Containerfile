FROM  quay.io/sclorg/nodejs-20-c9s@sha256:3e454658b8f0ba83a0a062ed0a8817a9720e9cd0e6fa0f813fe38dc4f4bb91a8 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:3e1214812edf1430c850aa2446c931e6c731e9884580b098c724dc2eb0ff4392 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]