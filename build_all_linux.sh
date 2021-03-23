#!/bin/bash

ln -s pom/pom.sh /usr/local/bin/pom-gen
chmod +x /usr/local/bin/pom-gen

cd recaf && ./mvnw package

