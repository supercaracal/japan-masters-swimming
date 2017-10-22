FROM postgres:9.6

MAINTAINER Taishi Kasuga

ARG BASE_BACKUP_FILE=""
COPY ./${BASE_BACKUP_FILE} /var/lib/postgresql/
RUN rm -rf /var/lib/postgresql/data/*                                            \
  && tar zxf /var/lib/postgresql/${BASE_BACKUP_FILE} -C /var/lib/postgresql/data \
  && chown -R postgres:postgres /var/lib/postgresql/data                         \
  && chmod 700 /var/lib/postgresql/data                                          \
  && rm /var/lib/postgresql/${BASE_BACKUP_FILE}

COPY ./postgresql.conf /etc/postgresql/
COPY ./pg_hba.conf     /etc/postgresql/
