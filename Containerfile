FROM  quay.io/sclorg/nodejs-20-c9s@sha256:ba79f05566ac513ff1118ee6f86bcca4cc7c2ffafb23258168610eb3dc1db92b AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:bcc1b1de5663477ce7585568ae2ea616da0fd7fb2c4cf57da25923e45cdb15e1 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]