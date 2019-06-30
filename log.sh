#!/bin/sh

export $(cat .env-default | grep -v '^#' | xargs)
export $(cat .env | grep -v '^#' | xargs)

cat $BATCH_LOG \
  | grep '"LogResult":' \
  | perl -MMIME::Base64 -nlpe 's/^(.+?)"LogResult": "//; s/".*$//; $_ = decode_base64($_)'