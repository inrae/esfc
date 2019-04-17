#!/bin/bash
/opt/sonar-scanner/bin/sonar-scanner \
 -Dsonar.projectKey=esfc \
 -Dsonar.sources=. \
 -Dsonar.host.url=https://sonarcloud.io \
 -Dsonar.organization=equinton-github \
 -Dsonar.login=4e5c6ec4233894236f4c7e85050c01924fa13453 \
 -Dsonar.exclusions=display/**,vendor/**,database/**,install/**,param/**,plugins/**,test/**,tmp/**

