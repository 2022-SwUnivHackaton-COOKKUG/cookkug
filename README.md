# COOKKUG

SW중심대학협의회 해커톤 - 쿡꾹

### 폴더구조
- screens : 각 화면의 UI
- widgets : 재사용되는 위젯
- utils : 자체적으로 사용되는 logic/function
- controllers : 각종 컨트롤러
- models : 모델
- services : 앱 내외적으로 통신(Local/Server(Fast API)/Firebase)
- constants.dart : 중복적으로 사용될수있는 Color, Style 등을 저장

### 참고
- 객체 클래스 자동생성 : flutter pub run build_runner build 를 루트 터미널에서 실행

### Github 작업
- pull(가져오기 -> git pull origin main을 통해 병합된 브랜치로부터 데이터를 가져와서 사용 가능)
- pull = fetch + merge (가장 최신버전을 가져온후에 merge하는거라 충돌날수도있어서 기왕이면 main에서 작업은 최대한 피하는것이 좋음)

1. git branch를 통해 현재 branch 확인
2. git branch 브랜치명 ex) git branch junghun2 를 통해 새로운 브랜치 생성 (작업할 브랜치 생성)
3. git checkout junghun2 와 같이 현재 브랜치를 이동한 후
4. git branch를 통해 브랜치가 올바르게 바뀌었나 확인
5. 작업후 git add 작업한 파일(편하게 . 사용도 가능하긴 함) 후 git commit ,git push를 통해 해당 브랜치에 기능 구현을 끝마치고 github에 업로드하기 -> 이후 선영님께 알리고 바로 merge되는걸 확인하는게 좋을거라 생각
6. 선영님이 main브랜치에서 merge하기(여러명이서 main에 push할경우 conflict가 자주나기때문에 이는 피하는게 좋지않을까 생각)
