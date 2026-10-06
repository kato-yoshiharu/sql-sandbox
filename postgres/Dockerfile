FROM postgres:16 AS database

RUN apt-get update && apt-get install -y \
  git \
  build-essential \
  postgresql-server-dev-16 \
  libicu-dev \
  && git clone https://github.com/pgbigm/pg_bigm.git \
  && cd pg_bigm \
  && make USE_PGXS=1 \
  && make USE_PGXS=1 install \
  && cd / \
  && rm -rf pg_bigm \
  && apt-get purge -y \
  git \
  build-essential \
  postgresql-server-dev-16 \
  libicu-dev \
  && apt-get autoremove -y \
  && apt-get clean

COPY ./databases/ /databases/
COPY ./init-databases.sh /docker-entrypoint-initdb.d/init-databases.sh
