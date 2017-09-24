# BUILD
FROM alpine:3.5

# Elixir/Erlang dev (project specific)
RUN apk --no-cache --update add \
  bash \
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
  erlang-tools \
  erlang-xmerl \
  git \
  libsass \
  make \
  nodejs \
  openssh-client \
  postgresql \
  python \
  wget

# Elixir
ENV ELIXIR_VERSION 1.5.1
ENV PATH $PATH:/opt/elixir-${ELIXIR_VERSION}/bin

RUN wget --no-check-certificate https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/Precompiled.zip \
  && mkdir -p /opt/elixir-${ELIXIR_VERSION}/ \
  && unzip Precompiled.zip -d /opt/elixir-${ELIXIR_VERSION}/ \
  && rm Precompiled.zip

RUN mix local.hex --force \
  && mix local.rebar --force

# The command to run when this image starts up
CMD ["/bin/sh"]

ENV WORKDIR /app
# Compile app
RUN mkdir $WORKDIR
WORKDIR $WORKDIR

# Copy elixir project contents
COPY mix.exs mix.lock ./
RUN mix deps.get \
 && MIX_ENV=test mix deps.get \
 && mkdir assets

COPY assets/package.json assets/package.json
RUN cd assets && npm install

COPY . .

ARG GIT_COMMIT="<git-commit>"
ARG GIT_BRANCH="<git-branch>"

RUN mkdir -p /opt/postgres /run/postgresql \
  && chown postgres: /opt/postgres /run/postgresql \
  && chmod 0700 /opt/postgres /run/postgresql \
  && su postgres -c "initdb /opt/postgres" \
  && (su postgres -c "postgres -D /opt/postgres" &) \
  && bash -c "export RETRIES=20; until pg_isready -U postgres || [[ \$RETRIES == 0 ]]; do echo \"Waiting for postgres server, \$((RETRIES--)) remaining attempts...\"; sleep 1; done" \
  && mix test 

# Compile and package for release, allow replace environment vars with REPLACE_OS_VARS
RUN (cd assets && ./node_modules/brunch/bin/brunch build -p) \
  && MIX_ENV=prod mix do compile, phx.digest, release --env=prod

RUN mkdir /release \
  && tar -xvf $WORKDIR/_build/prod/rel/conduit/releases/0.0.1/conduit.tar.gz -C /release

# RUNTIME
FROM alpine:3.5
ENV WORKDIR /app
WORKDIR $WORKDIR
# Exposes this port from the docker container to the host machine
ENV PORT 3000
EXPOSE $PORT
ENV REPLACE_OS_VARS true

# The command to run when this image starts up
CMD ["/app/bin/conduit", "foreground"]

# Install other stable dependencies that don't change often
# Compile app
# Distillery 1.5 requires bash (?)
RUN apk add --update --no-cache bash ncurses-libs libressl2.4-libcrypto

COPY --from=0 /release $WORKDIR/
