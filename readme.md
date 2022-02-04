# 개요
간단하게 Docker compose를 통해 개인 미디어위키(=비공개 미디어위키)를 빠르게 셋팅해보는 프로젝트입니다. 

`미디어위키 1.35.4`로 테스트를 했으며, VisualEditor도 동작합니다. 

개발 및 테스트용으로 사용하실 수 있으며, 프로덕션용으로 사용하는 것은 비추천합니다. (보안적 처리가 되어있지 않음)

프로덕션용으로 사용하시려면, 이것저것 수정하시면서 사용하시기 바랍니다.

<br><br><br>

# 도커 셋팅
1. `.example.env`를 복사해 `.env`파일을 생성하고 다음의 내용을 입력합니다.
    - DB_PASSWORD
    - DB_ROOT_PASSWORD
2. `.env`의 PORT 설정은 임의로 넣어놓은 것인데... 적절히 겹치지 않게 넣어두었습니다. 변경하시게 되면, LocalSettings.php 에서도 변경할 필요가 있습니다. 


3. docker 이미지 생성 및 compose 실행
    ```
    docker-compose up --build --force-recreate -d
    ```

## 컨테이너 중지
```
docker-compose stop
```
<br><br><br>

## 참고 사항
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

<br><br><br>

# 접속 방법

http://localhost:30189/w/


처음 접속시, 인스톨 과정을 진행함
* `http://localhost:30189/w/` 접속
* 설정을 따라 진행을 해보고, 다음다음을 눌러간다.
    - 데이터베이스 호스트 : `db`
    - 데이터베이스 이름 : `wiki`
    - 데이터베이스 사용자 이름 : `wiki`
    - 캐싱 설정 : `PHP 개체 캐싱 (APC, APCu 또는 WinCache)` 선택
* 데이터베이스에 테이블을 생성하고, `LocalSettings.php`를 만드는 과정을 진행합니다.


다음으로 할 일
1. 다운받은 `LocalSettings.php`를 적절히 수정해주었다면, 여기 폴더로 복사.
    - 미리 넣어둔 `LocalSettings.example.php`을 복사해서 `LocalSettings.php`로 수정하셔도 됩니다. (권장)
    - 직접 `LocalSettings.php`를 작성하셨다면, `LocalSettings.example.php`와 비교해서 없는 부분은 추가하시기 바랍니다. (parsiod 설정 등)
2. `LocalSettings.example.php`을 이용시 입력해야 하는 항목
    - `$wgDBpassword` : 데이터베이스 암호
    - `$wgSecretKey` : 키
    - `$wgUpgradeKey` : 키
3. `setup-mediawiki.sh` 실행
    ```
    docker-compose exec web /bin/bash /app/src/setup-mediawiki.sh
    ```
4. `http://localhost:30189` 접속

<br><br><br>


## 참고 사항
`setup-mediawiki.sh`의 내용
* `LocalSettings.php`를 미디어위키 폴더로 복사.
* `.htaccess`를 미디어위키 폴더로 복사.

