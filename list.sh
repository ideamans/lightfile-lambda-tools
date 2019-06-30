#!/bin/sh

export $(cat .env-default | grep -v '^#' | xargs)
export $(cat .env | grep -v '^#' | xargs)
export PYTHONIOENCODING=UTF-8

aws s3 ls s3://$BUCKET/$PREFIX --recursive \
  | grep -v '/$' \
  | perl -nlpe "s/^.{19} +\d+ //" \
  > $INVENTORY_TXT