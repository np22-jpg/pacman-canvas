FROM  quay.io/sclorg/nodejs-20-c9s@sha256:8f89e051b35a9acef5f4b180a7ebf5921c7e51f9f6f3a9694551f7401ea77394 AS build

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