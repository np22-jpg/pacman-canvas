FROM  quay.io/sclorg/nodejs-20-c9s@sha256:ff4a23013add976d58dd31265013a5d9ce71130e4fe45e5bde228772dd174c9e AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:17ebdfd3cfd9e1e7ac0db7b8a54ec420f857ac086629142ad1b6ed56b49831cd AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]