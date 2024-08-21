FROM  quay.io/sclorg/nodejs-20-c9s@sha256:15de34550ed4c48f202f8a5371575070472fb748aaab1e825b86cab3d4d3ba73 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:25e31ceae211f523f8be36868ec5fd2afdf076c42f192791c7c26eeb554f538e AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]