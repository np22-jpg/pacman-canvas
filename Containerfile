FROM  quay.io/sclorg/nodejs-20-c9s@sha256:70dbeef0f734525e7158905cea0ae43a29d79cee8971f25451d6a6b83601c7e7 AS build

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