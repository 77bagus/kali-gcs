#!/bin/bash
# Jalankan XRDP
systemctl restart xrdp

# Jalankan Localtonet dengan konfigurasi token dan domain yang diberikan
/usr/local/bin/localtonet tunnel -t 2JZVe3m64YOHA9hWBxityFdblonDaNfpR -p 3390 -d luejevh.localto.net
