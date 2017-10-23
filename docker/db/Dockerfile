FROM postgres:9.5

ARG BASE_BACKUP_FILE=""

ENV LANG            "ja_JP.utf8"
ENV BASEBACKUP_FILE "/tmp/basebackup.tar.gz"
ENV DATA_DIR        "/var/lib/postgresql/swim"
ENV CONF_FILE       "/etc/postgresql/postgresql.conf"
ENV HBA_FILE        "/etc/postgresql/pg_hba.conf"

COPY ./base_backup_files/${BASE_BACKUP_FILE} ${BASEBACKUP_FILE}
COPY ./postgresql.conf                       ${CONF_FILE}
COPY ./pg_hba.conf                           ${HBA_FILE}

RUN localedef -i ja_JP -c -f UTF-8 -A /usr/share/locale/locale.alias ja_JP.UTF-8 \
  && mkdir -p ${DATA_DIR}                                                        \
  && rm -rf ${DATA_DIR}/*                                                        \
  && tar zxf ${BASEBACKUP_FILE} -C ${DATA_DIR}                                   \
  && rm ${BASEBACKUP_FILE}                                                       \
  && chmod 700 ${DATA_DIR}                                                       \
  && chown -R postgres:postgres ${DATA_DIR} ${CONF_FILE} ${HBA_FILE}
