FROM postgres:9.5

COPY ./entrypoint.sh /docker-entrypoint-initdb.d/swim-db-entrypoint.sh

ARG BASE_BACKUP_FILE=""
ENV BASEBACKUP_FILE "/tmp/basebackup.tar.gz"
COPY ./base_backup_files/${BASE_BACKUP_FILE} ${BASEBACKUP_FILE}
RUN chown postgres:postgres ${BASEBACKUP_FILE}
