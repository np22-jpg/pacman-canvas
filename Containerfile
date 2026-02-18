FROM  quay.io/sclorg/nodejs-20-c9s@sha256:2c5da3ff073cedc6926c06c91e4e722fb6cc0a35f1764959c5987334f67a2fd8 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:919fefb1f09d2452881549319d57b8b9f3cd19cb647f600d8d80d98c14d05940 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]