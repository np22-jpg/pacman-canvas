FROM  quay.io/sclorg/nodejs-20-c9s@sha256:b267f7b89519b280002eb51cd70cced91683a4aea5d401a657f337ba9ae43a1b AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:8109dab49ce4f351544721c4ec9809d29ca918682998fe215e00ebb6f7f97e05 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]