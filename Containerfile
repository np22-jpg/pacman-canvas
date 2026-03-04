FROM  quay.io/sclorg/nodejs-20-c9s@sha256:d27ea23904c46cee8a6b2d571ae9d4e8bfce12b01befa5c5e5134d69ecaaf8d0 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:6902b67340e2061d45a869dece9159eed1fd93202a80ad99de63cc33c6c9db42 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]