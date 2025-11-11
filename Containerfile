FROM  quay.io/sclorg/nodejs-20-c9s@sha256:3dbb1c3f58ccf3319ab71b0d779e1b1fab1a875457394d90dac147e29bdc3924 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:a1b68c8526adc134ff785c5781060495dc7b02d6f97dac375c6184a7c1f0fa10 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]