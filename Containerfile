FROM  quay.io/sclorg/nodejs-20-c9s@sha256:12a3e098567102ed080f57b5b4290ec64f7acd6e17529df78f027e5615af3c4c AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:ab317d4cb337d8a922db079f04673c75f02d91fcb261d9e526bf28bc591aa747 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]