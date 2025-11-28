FROM  quay.io/sclorg/nodejs-20-c9s@sha256:086a839de3e2a596231a5fe16115c01e9f5a9849a2da53c89d223583a4518c26 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:802daa0d1d6b1f73e34262b1cda01f1d6b587b313896538fd53d2ac4b131963d AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]