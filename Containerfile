FROM  quay.io/sclorg/nodejs-20-c9s@sha256:c0e7fe01659cf83e6809de9d9721078d88587a44cae0505f03f4d234b8a649e8 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:1439bccc0b6d2524092763c7e396407a6822f6ab164bf7391a728b6a4201cca9 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]