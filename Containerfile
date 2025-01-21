FROM  quay.io/sclorg/nodejs-20-c9s@sha256:5e64488e2578aa9bfab7baf3a414bd130fd855ca032edc10742775a8f5e9be75 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:ad6ec801846f615a5aa59213c3a4ac284a86e3f0553cba5532f07ef4ce0a0bcd AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]