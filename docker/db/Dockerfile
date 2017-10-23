FROM postgres:9.6

ARG BASE_BACKUP_FILE=""

ENV BASEBACKUP_FILE "/tmp/basebackup.tar.gz"
ENV CONF_FILE "/tmp/postgresql.conf"
ENV HBA_FILE "/tmp/pg_hba.conf"

COPY ./entrypoint.sh                         /docker-entrypoint-initdb.d/swim-db-entrypoint.sh
COPY ./base_backup_files/${BASE_BACKUP_FILE} ${BASEBACKUP_FILE}
COPY ./postgresql.conf                       ${CONF_FILE}
COPY ./pg_hba.conf                           ${HBA_FILE}
