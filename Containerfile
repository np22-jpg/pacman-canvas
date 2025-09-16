FROM  quay.io/sclorg/nodejs-20-c9s@sha256:85788559da8455ba7245063af24af3b39eef9836a08e31903236e0c48a518b29 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:d049f0ece64aeb18c464a8f018ce9221dd9f9b4d237af4dcadf320c28cd6f594 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]