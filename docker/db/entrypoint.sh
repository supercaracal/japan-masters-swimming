#!/bin/bash

if [ -e "${BASEBACKUP_FILE}" ]; then
  tar zxf ${BASEBACKUP_FILE} -C ${PGDATA}
  chown -R postgres:postgres ${PGDATA}
  chmod 700 ${PGDATA}
  rm ${BASEBACKUP_FILE}
fi
