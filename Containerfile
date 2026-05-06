FROM  quay.io/sclorg/nodejs-20-c9s@sha256:052e11a3d5fedfb7562a0dcda9905d7e7a8c7bd59ef1f05a498e72205fbfab5b AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:b819fb146a11f5fc704d23837a69325f0ba832d5f6079b09b9f2da3efe9caed9 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]