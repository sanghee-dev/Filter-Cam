# Filter-Cam🌆
RxSwift를 사용하여 만든 사진 필터 어플입니다.

## 스킬
- Swift
- MVC Pattern

## 라이브러리
- RxSwift
- RxCocoa
- SnapKit
- CoreImage

## 기술 블로그
https://velog.io/@leeesangheee/Mastering-RxSwift-4%EA%B0%95-RxSwift%EB%A5%BC-%EC%9D%B4%EC%9A%A9%ED%95%B4-%EC%82%AC%EC%A7%84-%ED%95%84%ED%84%B0-%EC%95%B1-%EB%A7%8C%EB%93%A4%EA%B8%B0

## 화면

### 사진 목록 불러오기
- 메인 화면의 추가 버튼을 클릭하면 기기의 사진들을 가져와 컬렉션뷰에 띄웁니다.
- 사진은 최신 사진부터 보여줍니다.
- 사진을 클릭하면 다시 메인 화면으로 이동하며, 선택한 사진이 보여집니다.

<img src="https://user-images.githubusercontent.com/61302874/138220667-987dfc6d-d5c1-409e-8f06-8b64445b95b1.png" width="300" align="left" >
<img src="https://user-images.githubusercontent.com/61302874/138220683-bcf98ab2-bffc-4ca8-adeb-026567be1d82.png" width="300" >

### 필터 적용
- 메인 화면에 선택한 사진이 추가되면 필터를 적용할 수 있습니다.
- 적용 버튼을 눌러 필터를 적용하면, 필터가 적용된 사진을 확인할 수 있습니다.
- 적용한 후 다시 취소 버튼을 눌러 이전 상태로 돌릴 수 있습니다.

<img src="https://user-images.githubusercontent.com/61302874/138220793-686e2949-6011-4070-81d3-34327cc148a3.png" width="300" align="left" >
<img src="https://user-images.githubusercontent.com/61302874/138220826-70b99d4d-0d17-49a3-9478-78459f976fd2.png" width="300" >

### 필터 변경
- 필터는 하프톤, 세피아톤, 모노톤이 있습니다.
- 필터 버튼을 클릭하면 필터 종류들을 선택할 수 있습니다.
- 필터는 모델로 구현되며 필터의 CIKey, 이름(한글), 배경색상값을 가지고 있습니다.
- 필터가 변경되면 버튼의 UI를 변경합니다.
- 이전에 필터가 이미 적용이 되어서 취소 버튼이더라도 필터가 변경되면 적용 버튼으로 바뀝니다(사용자가 필터를 적용하고자 필터를 변경하는 목적이 크기에 버튼은 적용 버튼으로 바뀝니다).

<img src="https://user-images.githubusercontent.com/61302874/138220862-97ee29a9-f73a-4893-abea-b7efe0735263.png" width="300" align="left" >
<img src="https://user-images.githubusercontent.com/61302874/138220893-9f9ccc3a-e9cb-4eab-886c-8eb673a8b42f.png" width="300" >

<img src="https://user-images.githubusercontent.com/61302874/138220905-05e88c3b-4376-481f-ae88-ec0d855f93f3.png" width="300" align="left" >
<img src="https://user-images.githubusercontent.com/61302874/138220929-bdcffd68-50c0-44b4-90ac-a559531a83b0.png" width="300" >
