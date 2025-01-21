FROM  quay.io/sclorg/nodejs-20-c9s@sha256:5e64488e2578aa9bfab7baf3a414bd130fd855ca032edc10742775a8f5e9be75 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:cb897b428e49ff1e2ef41da2e8f3de49bd5b2dbb97afdfbf1fa70d3907897a87 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]