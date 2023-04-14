#! /bin/bash
# 개발 환경을 위한 Dockerfile. (프로덕션용이 아님)

if ! [ -d /app ]; then
	echo "not found /app"
	exit 1
fi


if ! [ -d /app/src/mediawiki/extensions ]; then
	cd /app/src
	# 미디어위키 인스톨 실행
	bash install-mediawiki.sh
fi

# 설정파일이 존재할 경우에 심볼릭 생성
if [ -f /app/src/config/LocalSettings.php ]; then
	if ! [ -f /app/src/mediawiki/LocalSettings.php ]; then
		ln -s ../config/LocalSettings.php /app/src/mediawiki/LocalSettings.php
	fi
fi

cd /app

# db 서버를 기다리기
# echo "wait db server"
# dockerize -wait tcp://db:3306 -timeout 20s

# 서버 실행
echo "Apache server is running..."
source /etc/apache2/envvars
exec apache2 -DFOREGROUND