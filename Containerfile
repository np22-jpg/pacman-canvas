FROM  quay.io/sclorg/nodejs-20-c9s@sha256:3d59106a0791b040615e7df315c8fbdfdf8fc2f976f54d8eae3cb80f06ebcfa3 AS build

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