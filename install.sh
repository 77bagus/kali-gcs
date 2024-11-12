#!/bin/bash
docker build -t kali-xrdp .
docker run -d --name kali-xrdp kali-xrdp
docker exec -d kali-xrdp tail -f /dev/null
