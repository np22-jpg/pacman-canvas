FROM  quay.io/sclorg/nodejs-20-c9s@sha256:918f413cb9758df8738f8b4615dffbf59f0d4d10ed9afd32f741645d062a9fe1 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:e6c89c25079184a5d12c127589153828c1a0c29b9ed65795cc6e0cd2f992d220 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]