FROM  quay.io/sclorg/nodejs-20-c9s@sha256:47398d4240cac03883c84ba18e5dc7c34bc651c8430a9217dec2632d83c172c4 AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:9a34a5cec050808c9c3896761977f3c4464a72c61b95a9501ff276091ad69564 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]