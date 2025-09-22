FROM  quay.io/sclorg/nodejs-20-c9s@sha256:de192d4f305889338808c01cad0938df39fabfca0c7aac863c950d3046582915 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:f7860544bd88611f9b46ca075ef6a16ef412dca10bd4bb9047e0a07f9ee80654 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]