FROM  quay.io/sclorg/nodejs-20-c9s@sha256:bbc90a422b98273cc0c65db7718fbbbe9e1f96e312019138ee828d5981cbf5f5 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:0c76e86acc034ab8cec0200f6f06131028688fc480d938db0bf85c75d0ce0492 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]