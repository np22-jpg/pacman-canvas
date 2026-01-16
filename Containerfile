FROM  quay.io/sclorg/nodejs-20-c9s@sha256:5d5ae04b5c26051506f6d82784fbe285d7b8263f4f3e77b33a60c3a6b715c444 AS build

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