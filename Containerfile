FROM  quay.io/sclorg/nodejs-20-c9s@sha256:12e753dda32c7672ed48c1f89131c8ac26612a4f8e458513fc1d92484a593afb AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:8877e65376ab222323dfca3475b6b327bddeff7292893adda656c5a29f81b74a AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]