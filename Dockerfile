FROM docker.io/rust:slim-buster AS builder

RUN USER=root cargo install cargo-auditable
RUN USER=root cargo new --bin nostr-rs-relay
WORKDIR ./nostr-rs-relay
COPY ./Cargo.toml ./Cargo.toml
COPY ./config.toml ./config.toml
COPY ./Cargo.lock ./Cargo.lock
# build dependencies only (caching)
RUN apt update && apt install -y openssl libssl-dev pkg-config
RUN cargo auditable build --release --locked
# get rid of starter project code
RUN rm src/*.rs

# copy project source code
COPY ./src ./src

# build auditable release using locked deps
RUN rm ./target/release/deps/nostr*relay*
RUN apt update && apt install -y openssl libssl-dev pkg-config
RUN cargo auditable build --release --locked

FROM docker.io/rust:slim-buster

ARG APP=/usr/local/bin
ARG APP_DATA=${APP}/data
RUN apt update && apt install -y openssl libssl-dev pkg-config
RUN apt-get update \
    && apt-get install -y ca-certificates tzdata sqlite3 libc6 openssl libssl-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 8080 3232

ENV TZ=Etc/UTC
ENV APP_USER=appuser
ENV APP=${APP}
ENV APP_DATA=${APP}/data

RUN groupadd $APP_USER \
    && useradd -g $APP_USER $APP_USER \
    && mkdir -p ${APP} \
    && mkdir -p ${APP_DATA}

COPY --from=builder /nostr-rs-relay/target/release/nostr-rs-relay ${APP}/nostr-rs-relay
COPY ./config.toml ${APP}/config.toml
RUN chown -R $APP_USER:$APP_USER ${APP}

USER $APP_USER
WORKDIR ${APP}

ENV RUST_LOG=info,nostr_rs_relay=info
ENV APP_DATA=${APP_DATA}

ENTRYPOINT [ "nostr-rs-relay" ]
