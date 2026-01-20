FROM  quay.io/sclorg/nodejs-20-c9s@sha256:d141dc7ee127bea97b854ff1dd280165c358f2fc9c5b62d1cb281bc6011672a5 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:0396353845ebc447c1091f2608a1e2127383866f51e2e497fba1fc7bf8456337 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]