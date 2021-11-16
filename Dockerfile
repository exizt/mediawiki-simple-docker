# 개발 환경을 위한 Dockerfile. (프로덕션용이 아님)
FROM php:7.4-apache-bullseye

WORKDIR /app

# 필요한 것들 설치
# - wget : dockerize에서 필요
# - git, unzip : composer 에서 필요
# - imagemagick : 미디어위키에서 섬네일할 때 필요
# - php-apcu : apcu 캐싱 (데이터베이스 결과 캐싱)
# - libicu-dev : intl을 위해 필요한 듯.
RUN  apt-get update \
    && apt-get install -y \
    wget \
    imagemagick \
    libicu-dev \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# apcu
RUN pecl install apcu-5.1.21 && docker-php-ext-enable apcu

# php extension 설치
RUN docker-php-ext-install bcmath mysqli

# intl
RUN docker-php-ext-configure intl && docker-php-ext-install intl && docker-php-ext-enable intl

# apache enable mode
RUN a2enmod rewrite headers

# DB 연결에 대기시킬 수 있는 기능을 하는 Dockerize 를 이용
ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz


# Set the ENV vars
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2

# 포트
EXPOSE 80

# 도커에서 dforground 옵션으로 동작시킬 것이기 때문에 서비스에서는 종료.
RUN service apache2 stop

# entrypoint.sh 복사
COPY docker-entrypoint.sh .

# 
WORKDIR /app
