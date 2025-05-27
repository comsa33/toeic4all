# 🚀 Kakao 및 Naver 소셜 로그인 설정 가이드

## ✅ 현재 완료된 작업

### 1. **코드 구현 (100% 완료)**
- ✅ `KakaoSignInService` 구현
- ✅ `NaverSignInService` 구현  
- ✅ `KakaoLoginMobileUseCase` 구현
- ✅ `NaverLoginMobileUseCase` 구현
- ✅ `AuthController` Kakao/Naver Sign-In 연동
- ✅ UI 이미  연결됨 (`_handleSocialLogin('kakao')`, `_handleSocialLogin('naver')`)
- ✅ 백엔드 API 연동 (`/social/kakao/mobile`, `/social/naver/mobile`)

### 2. **Flutter 의존성 (완료)**
- ✅ `kakao_flutter_sdk: ^1.9.1` 설치됨
- ✅ `flutter_naver_login: ^1.8.0` 설치됨

### 3. **플랫폼 설정 (기본 설정 완료)**
- ✅ Android: Kakao/Naver intent-filter 추가됨
- ✅ iOS: Kakao/Naver URL schemes 추가됨
- ✅ main.dart: SDK 초기화 코드 추가됨

## 🔧 **남은 작업: 실제 앱 키 설정**

### **1단계: Kakao Developers 설정**
1. **Kakao Developers Console 접속**: https://developers.kakao.com/
2. **새 애플리케이션 생성**:
   - 앱 이름: `TOEIC4ALL`
   - 회사명: (본인 회사명)
3. **네이티브 앱 키 확인**: 
   - 일반 > 앱 키 > 네이티브 앱 키 복사
4. **플랫폼 설정**:
   - **Android**: 
     - 패키지명: `com.ruo.toeic.toeic4all`
     - 키 해시: (아래 명령어로 확인)
   - **iOS**:
     - Bundle ID: `com.ruo.toeic.toeic4all`
5. **Redirect URI 설정**:
   - `kakao{NATIVE_APP_KEY}://oauth`

### **2단계: Naver Developers 설정**
1. **Naver Developers Console 접속**: https://developers.naver.com/
2. **애플리케이션 등록**:
   - 애플리케이션 이름: `TOEIC4ALL`
   - 서비스 URL: `https://your-backend-domain.com`
3. **API 설정**:
   - 로그인 오픈 API 사용: 체크
   - 제공정보 선택: 이메일, 프로필 정보
4. **플랫폼 추가**:
   - **Android**: 패키지명 `com.ruo.toeic.toeic4all`
   - **iOS**: Bundle ID `com.ruo.toeic.toeic4all`

### **3단계: 실제 키 값 설정**

#### main.dart 업데이트:
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Kakao SDK
  KakaoSdk.init(nativeAppKey: 'YOUR_ACTUAL_KAKAO_NATIVE_APP_KEY');
  
  // Initialize Naver SDK
  await FlutterNaverLogin.initSdk(
    clientId: 'YOUR_ACTUAL_NAVER_CLIENT_ID',
    clientSecret: 'YOUR_ACTUAL_NAVER_CLIENT_SECRET', 
    clientName: 'TOEIC4ALL',
  );
  
  // ... 나머지 코드
}
```

#### Android 설정 업데이트:
`android/app/src/main/AndroidManifest.xml`에서:
```xml
<data android:scheme="kakao{실제_카카오_네이티브_앱키}" />
```

#### iOS 설정 업데이트:
`ios/Runner/Info.plist`에서:
```xml
<string>kakao{실제_카카오_네이티브_앱키}</string>
```

### **4단계: 키 해시 확인 (Android)**
```bash
# macOS/Linux
keytool -exportcert -alias androiddebugkey -keystore ~/.android/debug.keystore -storepass android -keypass android | openssl sha1 -binary | openssl base64

# Windows  
keytool -exportcert -alias androiddebugkey -keystore %USERPROFILE%\.android\debug.keystore -storepass android -keypass android | openssl sha1 -binary | openssl base64
```

## 🧪 **테스트 방법**

### 테스트 순서
1. ✅ **코드는 이미 완성됨**
2. 🔧 **Kakao/Naver 개발자 콘솔 설정**
3. 🔧 **실제 앱 키 값 입력**
4. 🧪 **앱에서 소셜 로그인 버튼 테스트**

### 예상 플로우
1. **소셜 로그인 버튼 클릭** (Kakao/Naver)
2. **해당 앱 또는 웹뷰 열림**
3. **계정 로그인/선택**
4. **앱으로 자동 복귀**
5. **Access Token 백엔드 전송**
6. **로그인 성공** → 문제 서비스 화면 이동

## 🎯 **아키텍처 (올바름)**
```
Flutter App 
  ↓ 
Kakao/Naver SDK
  ↓
Kakao/Naver OAuth 서버
  ↓ (Access Token 반환)
Flutter App
  ↓ (Access Token 전송)
우리 백엔드 API (/social/kakao/mobile, /social/naver/mobile)
  ↓ (JWT 토큰 반환)
Flutter App (로그인 완료)
```

## 📋 **백엔드 개발자 확인사항**
✅ **API 엔드포인트 구현됨**:  
- `POST /api/v1/auth/social/kakao/mobile` (body: `{"access_token": "..."}`)
- `POST /api/v1/auth/social/naver/mobile` (body: `{"access_token": "..."}`)
✅ **응답 형식**: Google 로그인과 동일한 JWT 토큰 형식

## 🏁 **다음 단계**
1. Kakao/Naver 개발자 콘솔에서 앱 등록
2. 실제 앱 키 값 main.dart에 입력
3. Android/iOS 설정 파일에 실제 키 값 반영
4. 실제 디바이스/시뮬레이터에서 테스트
5. 완료!

---
**최종 상태**: 코드 100% 완료, 앱 키 설정만 남음
