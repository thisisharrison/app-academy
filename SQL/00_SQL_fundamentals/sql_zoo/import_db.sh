#!/usr/bin/env sh

dropdb sqlzoo
createdb sqlzoo
psql < data/create_tables.sql
