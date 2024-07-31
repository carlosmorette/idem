FROM elixir:1.16-otp-26
WORKDIR /app

COPY mix.exs mix.lock ./
COPY lib lib
COPY config config
COPY docker_entrypoint.sh .

RUN mix do deps.get, deps.compile, compile

CMD ["./docker_entrypoint.sh"]
