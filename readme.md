# 개요

간단하게 `Docker`를 이용하여 미디어위키를 설치해보는 목적.

개발 및 테스트용으로 사용하실 수 있으며, 프로덕션용으로 사용하는 것은 비추천합니다. (보안적 처리가 되어있지 않음)

<br><br><br>

# 도커 셋팅
1. `.example.env`를 복사해 `.env`파일을 생성하고, 설정을 진행.
    - `APP_PORT_EXTERNAL` : 브라우저에서 접근시 사용될 포트 번호
    - `DB_PASSWORD` : 위키에 사용될 해당 데이터베이스의 암호
    - `DB_ROOT_PASSWORD` : 데이터베이스 루트 암호
2. docker 이미지 생성 및 compose 실행
    ```
    docker-compose up --build --force-recreate -d
    ```
3. 인스톨 과정을 진행
    - `http://localhost:(설정한포트)/w/` 접속
    - 설정을 따라 진행을 해보고, 다음다음을 눌러간다.
        - 데이터베이스 종류 : `MariaDB, MySQL 및 호환` 선택
        - 데이터베이스 호스트 : `db`
        - 데이터베이스 이름 : `wiki`
        - 데이터베이스 사용자 이름 : `wiki`
        - 데이터베이스 비밀번호 : 앞서 `.env`에서 설정했던 데이터베이스 암호를 입력
        - 캐싱 설정 : `PHP 개체 캐싱 (APC, APCu 또는 WinCache)` 선택
    - 데이터베이스에 테이블이 생성되고, `LocalSettings.php`파일을 다운로드 받는다.
4. `LocalSettings.php`파일을 `config` 디렉토리 밑에 붙여넣기
5. docker 재시작
    ```
    docker-compose restart
    ```

# 참고 사항
도커 이미지 생성 과정에서 처리되는 것
* php, apache 설치
* php 확장 기능
    * imagemagick (썸네일 처리 기능 지원) 설치
    * libicu, intl (성능 향상 관련) 설치
    * apcu (성능 향상 관련) 설치
    * apache 셋팅

도커 컨테이너 실행 과정에서 처리되는 것
* `docker-entrypoint.sh` 실행
    * 내부에서 `install-mediawiki.sh`스크립트 실행됨 : 미디어위키 다운로드, 압축 해제, 퍼미션 조정
