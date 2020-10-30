FROM elixir:1.11-alpine

RUN mix local.hex --force
RUN mix local.rebar --force

WORKDIR /parallel_download
