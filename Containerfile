FROM  quay.io/sclorg/nodejs-20-c9s@sha256:c04df17cc49788933e36df5ffe014c7ba118023a41aa50a15e3ca541f096c619 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:9953f3f8e1bbb83cb710e2b2ef1f0137ce3c795364fea3f276d4fce47562d710 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]