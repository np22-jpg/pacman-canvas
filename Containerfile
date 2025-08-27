FROM  quay.io/sclorg/nodejs-20-c9s@sha256:ff4a23013add976d58dd31265013a5d9ce71130e4fe45e5bde228772dd174c9e AS build

USER root
RUN npm install -g pnpm

WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod

COPY ./ ./



FROM  quay.io/sclorg/nodejs-20-minimal-c9s@sha256:666801dd26bf735eb252b62047cc2abfff7a2230482bdacf9bc8960004acd5f7 AS release

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY --from=build --chown=default /app /app

CMD [ "/usr/bin/node", "server.js" ]