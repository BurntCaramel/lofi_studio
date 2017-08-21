FROM elixir:alpine as elixir

WORKDIR /app
COPY ./ ./

RUN mix local.hex --force
RUN mix deps.get
RUN ls /app


# Multiple FROM: https://stackoverflow.com/a/33322374
FROM node:8-alpine as node

WORKDIR /app
ENV MIX_ENV=prod

COPY --from=elixir /app ./
COPY assets /app/assets

RUN ls /app

RUN cd /app/assets && npm install && npm run deploy


FROM elixir:alpine as elixir2
WORKDIR /app
ENV MIX_ENV=prod

COPY --from=node /app ./
#COPY --from=elixir /app/deps ./deps/

RUN mix local.rebar --force
RUN mix local.hex --force
RUN mix deps.get
RUN mix phx.digest

RUN which mix

EXPOSE 4000
CMD ["mix", "phx.server"]
