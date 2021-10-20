#!/bin/bash
if [ $# -ne 2 ]; then
  echo "Usage:   $0 -i <emp_id>" >&2
  exit 1
fi
while getopts ":i:" flag
do
  case "$flag" in
    i) emp_id="$OPTARG";;
    ?)
      echo "Error: Invalid option was specified -$OPTARG" >&2
      exit 1
      ;;
  esac
done

b64token='admin:admin'
api_url='localhost:8080/api'
url="${api_url}/employees/${emp_id}/attendance/exit-time"
date_fmt='%Y-%m-%d %H:%M:%S'
leftAt=$( date +"${date_fmt}" )

body="{\"leftAt\": \"${leftAt}\"}"

curl -X PATCH -u "${b64token}" -H "Content-Type: application/json;charset=UTF-8" -d "${body}" "${url}"

