FROM  quay.io/sclorg/nodejs-20-c9s@sha256:a2fb27fbcc1728a2292085e7f467ff0d6edcd68f84db106cc16ee457fbe379e7 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:fe85a923710a2066d1185602f92d9943d231ee3620d055dce82ed89cf2f5e063 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]