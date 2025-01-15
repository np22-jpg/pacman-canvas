FROM  quay.io/sclorg/nodejs-20-c9s@sha256:b9948f0ac0edb0587ba3ee2dcaf7b048bd29762e902d8ac30b90018ed7379ff0 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:b009ca835c33792e7f263b630575d6cdf9efcf67069b5d57115a28d39ac1169f AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]