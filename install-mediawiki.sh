#!/bin/bash

cd /app
mkdir -p /app/public

# 미디어위키 인스톨 스크립트. tar 이용.

# 다운로드
# wget https://releases.wikimedia.org/mediawiki/1.36/mediawiki-1.36.2.tar.gz
wget https://releases.wikimedia.org/mediawiki/1.35/mediawiki-1.35.4.tar.gz

# 압축 해제
# tar xvzf mediawiki-1.36.2.tar.gz && mv mediawiki-1.36.2 /app/public/w && rm mediawiki-1.36.2.tar.gz
tar xvzf mediawiki-1.35.4.tar.gz && mv mediawiki-1.35.4 /app/public/w && rm mediawiki-1.35.4.tar.gz

# 퍼미션 조정
chown www-data:www-data /app/public/w/images