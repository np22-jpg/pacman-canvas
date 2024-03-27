FROM  quay.io/sclorg/nodejs-20-c9s@sha256:ab786b6f252b24c23820da981cea0c8b35e65cb2fb4e64bb498397d78ffcf8c8 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:b1db29b402c28cb93d3c37144cebfd0369ff3f3b1aad4f866b3e8c94c54c7300 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]