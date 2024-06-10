FROM  quay.io/sclorg/nodejs-20-c9s@sha256:58dac6024bdf84bbd35936eb060ad0f0a70b2c1acb892a036c227df52268a75f AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:16e6788877c21a0188463c1f5598c8b59b7d467b7a2d98b46ba09ac494b0b1ac AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]