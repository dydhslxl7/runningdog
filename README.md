# Runningdog Project
###### 구현 기간 : 20/09/08 ~ 20/09/29
> 유기동물과 관련된 정보들을 주고받을 수 있는 사이트입니다.

## 구현 기능
+ 후원하기 CRUD
+ 공유 기능
+ 결제 기능
+ [sponsor](https://github.com/dydhslxl7/runningdog/tree/main/src/main/java/com/kh/runningdog/sponsor)
+ [Admin sponsor](https://github.com/dydhslxl7/runningdog/tree/main/src/main/java/com/kh/runningdog/admin/sponsor/controller)
+ [view 페이지](https://github.com/dydhslxl7/runningdog/tree/main/src/main/webapp/WEB-INF/views/sponsor)
+ [sponsor 관리자 페이지](https://github.com/dydhslxl7/runningdog/tree/main/src/main/webapp/WEB-INF/views/admin/userBoard)
+ [sponsor mapper](https://github.com/dydhslxl7/runningdog/tree/main/src/main/resources/mappers)
+ [sponsor.js](https://github.com/dydhslxl7/runningdog/blob/main/src/main/webapp/resources/common/js/sponsor.js)

## 상세 기능 설명
1. 후원하기 CRUD
   + 썸네일 사진 첨부 시 썸네일용 리사이징버전과 본문노출용 원본사진, 두버전 저장
   + 본문 내용은 썸머노트 API 사용
   + 썸머노트 API로 사진 등록 시 고유의 URL을 리턴
   + 스케쥴러를 이용해 서버에 올려진 사진과 게시글에 올려진 사진 비교 후 게시글에 존재하지 않는 사진 삭제
   + 조회수 쿠키 이용해 중복 방지
   + 체크박스로 일괄 삭제 기능
   + 페이징 처리
   + 분류(제목, 내용) 별 검색 기능
   + 검색 후 페이지 이동 시 검색결과 유지
   + 후원완료 시 후원완료 아이콘 표시
   + 게시글 수정 기능
2. 공유 기능
   + 네이버, 카카오톡, 페이스북, 트위터의 공유기능
   + URL 복사 기능
3. 결제 기능
   + 신용카드, 무통장입금 두가지 방법 제시
   + 신용카드 선택 시 아임포트로 구현한 이니시스 결제창 노출

## 포트폴리오
[PDF 포트폴리오](https://drive.google.com/file/d/1aHE6AHJsivhf5xHuwQCw3sDJpeY0EPIJ/view)

## 🛠 개발환경
+ &#128187; Java | JSP | Spring 3.9.13
+ &#127760; HTML | CSS | JavaScript | jQery 3.5.1
+ 🛢 Oracle Database 11g | SQL
+ &#128295; Git | SourceTree
+ &#128235; apache-tomcat-8.5.57
