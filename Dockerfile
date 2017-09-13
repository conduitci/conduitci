# BUILD
FROM alpine:3.5

# Elixir/Erlang dev (project specific)
RUN apk --no-cache --update add \
  build-base \
  ca-certificates \
  erlang \
  erlang-asn1 \
  erlang-crypto \
  erlang-dev \
  erlang-erl-interface \
  erlang-inets \
  erlang-parsetools \
  erlang-public-key \
  erlang-runtime-tools \
  erlang-sasl \
  erlang-ssl \
  erlang-syntax-tools \
  erlang-xmerl \
  git \
  make \
  nodejs \
  openssh-client \
  python \
  wget

# Elixir
ENV ELIXIR_VERSION 1.4.4
ENV PATH $PATH:/opt/elixir-${ELIXIR_VERSION}/bin

RUN wget --no-check-certificate https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/Precompiled.zip && \
  mkdir -p /opt/elixir-${ELIXIR_VERSION}/ && \
  unzip Precompiled.zip -d /opt/elixir-${ELIXIR_VERSION}/ && \
  rm Precompiled.zip

RUN mix local.hex --force && \
  mix local.rebar --force

# The command to run when this image starts up
CMD ["/bin/sh"]

# Compile app
RUN mkdir /app
WORKDIR /app

# Copy elixir project contents
COPY mix.exs mix.lock ./
RUN MIX_ENV=prod mix deps.get
COPY . .

# Compile and package for release, allow replace environment vars with REPLACE_OS_VARS
RUN MIX_ENV=prod mix compile && \
  (\
    cd assets && \
    npm install && \
    ./node_modules/brunch/bin/brunch build -p \
  ) && \
  MIX_ENV=prod mix do phx.digest, release --env=prod

RUN mkdir /release && \
  tar -xvf /app/_build/prod/rel/conduit/releases/0.0.1/conduit.tar.gz -C /release


# RUNTIME
FROM alpine:3.5

# Exposes this port from the docker container to the host machine
ENV PORT 3000
EXPOSE $PORT
ENV REPLACE_OS_VARS true

# The command to run when this image starts up
CMD ["/app/bin/conduit", "foreground"]

# Install other stable dependencies that don't change often
# Compile app
# Distillery 1.5 requires bash (?)
RUN mkdir /app && apk add --update --no-cache bash ncurses-libs

COPY --from=0 /release /app/
