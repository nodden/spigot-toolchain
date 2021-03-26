#!/bin/bash

cp pom/pom.sh /usr/local/bin/spipo
chmod +x /usr/local/bin/spipo

cd recaf && ./mvnw package
