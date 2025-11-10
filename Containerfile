FROM  quay.io/sclorg/nodejs-20-c9s@sha256:3dbb1c3f58ccf3319ab71b0d779e1b1fab1a875457394d90dac147e29bdc3924 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:c013eae31636e41fd846e80da2ae267a4de5a7a067fd1b660e4d60b9937d61ef AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]