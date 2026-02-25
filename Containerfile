FROM  quay.io/sclorg/nodejs-20-c9s@sha256:2662a942299eafe7b4664891e1796436e3c9ec40715f7061da3d4d9cf37c3642 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:6cc45b5a19a69b3cc1b31f258b5c654661d0f8cc472b42fcc206249809030b21 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]