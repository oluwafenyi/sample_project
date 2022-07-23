#!/bin/bash
# postgresql-client required

# replace placeholders
psql postgres://USERNAME:PASSWORD@HOSTNAME:PORT/DATABASE_NAME < filename.sql
