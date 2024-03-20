FROM  quay.io/sclorg/nodejs-20-c9s@sha256:b5fe5ca42bbce8ba939c6439625203f857f9f80ab3c978af75cfc444fe669568 AS build

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