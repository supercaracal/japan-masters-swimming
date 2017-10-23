#!/bin/bash

if [ -e "${BASEBACKUP_FILE}" ]; then
  tar zxf ${BASEBACKUP_FILE} -C ${PGDATA}
  chown -R postgres:postgres ${PGDATA}
  chmod 700 ${PGDATA}
  rm ${BASEBACKUP_FILE}
fi

if [ -e "${CONF_FILE}" ]; then
  #cp -f ${CONF_FILE} /etc/postgresql/
fi

if [ -e "${HBA_FILE}" ]; then
  #cp -f ${HBA_FILE} /etc/postgresql/
fi
