FROM  quay.io/sclorg/nodejs-20-c9s@sha256:4df3f1743485a3e6a9f9b226a49954dd6c88bc20af173073f976868642b24b18 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:acc85494c40dae1d76e0494dbbb0764690414641e099ccb77fcd284e8b38608f AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]