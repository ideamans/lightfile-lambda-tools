#!/bin/sh

export $(cat .env-default | grep -v '^#' | xargs)
export $(cat .env | grep -v '^#' | xargs)

cat $INVENTORY_TXT \
  | xargs -P $CONCURRENCY -I {} \
      aws lambda invoke \
        --invocation-type RequestResponse \
        --function-name $LAMBDA \
        --log-type Tail \
        --payload "{\"Records\":[{\"s3\":{\"bucket\":{\"name\":\"$BUCKET\"},\"object\":{\"key\":\"{}\"}}}]}" \
        $LAMBDA_OUTPUT \
        >> $BATCH_LOG
      
