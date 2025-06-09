FROM  quay.io/sclorg/nodejs-20-c9s@sha256:a5d751324a724db7b2f7ba59061a6bcd2d68cac6165f2eaf805577d81c58bca1 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:5211f7b0cd3f503e68358a37ec21b032565622fd761baae0f03e26095649cee5 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]