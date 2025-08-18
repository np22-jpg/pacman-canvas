FROM  quay.io/sclorg/nodejs-20-c9s@sha256:00be1bd97342046139048cd3c3eef2aa53a425386aba5fdae82ef83a45a6584f AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:0099473bc379b2a9ecfbfb8d9a065c5905f5845e231cb25c7ca92724eb57e0ab AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]