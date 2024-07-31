FROM  quay.io/sclorg/nodejs-20-c9s@sha256:d4a29228d455e8a0f2bbe6c647d4f2ed516598717f2c42f227800ce1266b2f10 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:a0273f8128d7688185a162a1d182fda67ce6b5935dce4996e373c5a1143a2ab0 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]