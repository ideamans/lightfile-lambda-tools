#!/bin/sh

export $(cat .env-default | grep -v '^#' | xargs)
export $(cat .env | grep -v '^#' | xargs)

aws s3 ls s3://$BUCKET/$PREFIX --recursive \
  | grep -v '/$' \
  | perl -nlpe "s/^.{19} +\d+ /$BUCKET,\"/; s/$/\"/" \
  > $INVENTORY_CSV