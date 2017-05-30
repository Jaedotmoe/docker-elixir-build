FROM alpine:latest

ENV ELIXIR_VERSION 1.4.4

RUN apk --no-cache add erlang-dev
RUN apk --no-cache add --virtual build-dependencies wget ca-certificates && \
    wget --no-check-certificate https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/Precompiled.zip && \
    mkdir -p /opt/elixir-${ELIXIR_VERSION}/ && \
    unzip Precompiled.zip -d /opt/elixir-${ELIXIR_VERSION}/ && \
    rm Precompiled.zip && \
    apk del build-dependencies 

ENV PATH $PATH:/opt/elixir-${ELIXIR_VERSION}/bin

CMD ["/bin/ash"]
