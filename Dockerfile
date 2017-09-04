FROM alpine:latest

ENV ELIXIR_VERSION 1.5.1

RUN apk --no-cache add erlang-dev erlang-inets \
    erlang-ssl erlang-crypto erlang-public-key erlang-asn1 erlang-sasl erlang-erl-interface \
    erlang-syntax-tools erlang-parsetools erlang-eunit erlang-tools erlang-dialyzer \
    erlang-hipe \
    git make

RUN apk --no-cache add --virtual build-dependencies wget ca-certificates && \
    wget --no-check-certificate https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/Precompiled.zip && \
    mkdir -p /opt/elixir-${ELIXIR_VERSION}/ && \
    unzip Precompiled.zip -d /opt/elixir-${ELIXIR_VERSION}/ && \
    rm Precompiled.zip && \
    apk --no-cache del build-dependencies 

RUN apk --no-cache add nodejs-npm

ENV PATH $PATH:/opt/elixir-${ELIXIR_VERSION}/bin

RUN mix local.hex --force
RUN mix local.rebar --force

CMD ["/bin/ash"]
