#!/bin/bash

cd /app
# mkdir -p /app/public

# 미디어위키 인스톨 스크립트. tar 이용.

# 다운로드
wget https://releases.wikimedia.org/mediawiki/1.39/mediawiki-1.39.2.tar.gz -O mediawiki-src.tar.gz
# wget https://releases.wikimedia.org/mediawiki/1.37/mediawiki-1.37.6.tar.gz -O mediawiki-src.tar.gz
# wget https://releases.wikimedia.org/mediawiki/1.35/mediawiki-1.35.8.tar.gz -O mediawiki-src.tar.gz

# 압축 해제
# tar xvzf mediawiki-src.tar.gz && mv mediawiki-src /app/public/w && rm mediawiki-src.tar.gz
# mkdir /app/public/w && tar xvzf mediawiki-src.tar.gz -C /app/public/w --strip-components 1 && rm mediawiki-src.tar.gz
# tar xvzf mediawiki-src.tar.gz -C /app/src/mediawiki --strip-components 1 && rm mediawiki-src.tar.gz
# tar xvzf mediawiki-src.tar.gz && mv mediawiki-src ./src/mediawiki && rm mediawiki-src.tar.gz
mkdir /app/src/mediawiki && tar xvzf mediawiki-src.tar.gz -C /app/src/mediawiki --strip-components 1 && rm mediawiki-src.tar.gz

# 퍼미션 조정
chown www-data:www-data /app/src/mediawiki/images