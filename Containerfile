FROM  quay.io/sclorg/nodejs-20-c9s@sha256:e9ceaac6570fb048afd13e1e5215f808e8d83f688df9bb05a8b0086e539eb047 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:426b3613f61de54609b068785d21c48f13839dbcec510e67fac0942b53667d05 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]