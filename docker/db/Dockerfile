FROM postgres:9.5

ARG BASE_BACKUP_DATE="YYYYMMDD"

ENV LANG     "ja_JP.utf8"
ENV DATA_DIR "/var/lib/postgresql/swim"

COPY ./base_backup_files/${BASE_BACKUP_DATE}.tar.gz /tmp/
COPY ./postgresql.conf                              /tmp/
COPY ./pg_hba.conf                                  /tmp/

RUN localedef -i ja_JP -c -f UTF-8 -A /usr/share/locale/locale.alias ja_JP.UTF-8 \
  && mkdir -p ${DATA_DIR}                                                        \
  && rm -rf ${DATA_DIR}/*                                                        \
  && tar zxf /tmp/${BASE_BACKUP_DATE}.tar.gz -C ${DATA_DIR}                      \
  && rm /tmp/${BASE_BACKUP_DATE}.tar.gz                                          \
  && mv -f /tmp/postgresql.conf ${DATA_DIR}/                                     \
  && mv -f /tmp/pg_hba.conf ${DATA_DIR}                                          \
  && chmod 700 ${DATA_DIR}                                                       \
  && chown -R postgres:postgres ${DATA_DIR}

CMD ["postgres", "-D", "${DATA_DIR}"]
