#!/bin/bash

FILE="src/main/resources/plugin.yml"

mkdir -p src/main/resources
touch "$FILE"

echo "name: $1" >> "$FILE"
echo "main: $2" >> "$FILE"
echo "version: 1.0" >> "$FILE"
echo "author: $3" >> "$FILE"
echo 'api-version: 1.13' >> "$FILE"

