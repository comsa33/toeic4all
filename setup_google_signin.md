# 🚀 Google Sign-In 설정 가이드 (Firebase 없이)

## ✅ 현재 상태
- ✅ 코드 구현 완료 (Firebase 의존성 없음)
- ✅ google_sign_in 패키지 설치됨
- ✅ Client ID 설정됨: `492018860076-5c1jfbpkk33c914rkh05k0he8c25thj6.apps.googleusercontent.com`

## 🔧 필요한 작업: Google Cloud Console 설정

### 1단계: SHA-1 지문 확인 (Android)
```bash
# Java 환경 설정
export JAVA_HOME=/opt/homebrew/opt/openjdk@11/libexec/openjdk.jdk/Contents/Home

# SHA-1 지문 확인
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
```

### 2단계: Bundle ID 확인 (iOS)
```bash
# Bundle ID 확인
grep -A 5 "PRODUCT_BUNDLE_IDENTIFIER" ios/Runner.xcodeproj/project.pbxproj
```

### 3단계: Google Cloud Console 설정
1. **Google Cloud Console 접속**: https://console.cloud.google.com/
2. **API 및 서비스** → **사용자 인증 정보**
3. **OAuth 2.0 클라이언트 ID 편집** (기존 Client ID)
4. **Android 앱 추가**:
   - 패키지 이름: `com.ruo.toeic.toeic4all`
   - SHA-1 지문: (1단계에서 확인한 값)
5. **iOS 앱 추가**:
   - Bundle ID: (2단계에서 확인한 값)

### 4단계: iOS 설정 파일 업데이트
```xml
<!-- ios/Runner/Info.plist에 추가 -->
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLName</key>
        <string>com.googleusercontent.apps.492018860076-5c1jfbpkk33c914rkh05k0he8c25thj6</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>com.googleusercontent.apps.492018860076-5c1jfbpkk33c914rkh05k0he8c25thj6</string>
        </array>
    </dict>
</array>
```

## 🧪 테스트 방법

### 테스트 순서
1. ✅ **코드는 이미 완성됨**
2. 🔧 **SHA-1 지문 확인 및 등록**
3. 🔧 **Bundle ID 확인 및 등록**  
4. 🔧 **iOS Info.plist 업데이트**
5. 🧪 **앱에서 Google 로그인 버튼 테스트**

### 예상 플로우
1. **Google 로그인 버튼 클릭**
2. **Google Sign-In SDK 화면 열림** (브라우저 또는 Google 앱)
3. **Google 계정 선택/로그인**
4. **앱으로 자동 복귀**
5. **ID Token 백엔드 전송**
6. **로그인 성공** → 문제 서비스 화면 이동

## ❌ Firebase가 불필요한 이유

우리는 이미 완벽한 아키텍처를 가지고 있습니다:

```
Flutter App → Google Sign-In SDK → Google OAuth → 백엔드 API
```

Firebase는 백엔드 서비스까지 제공하지만, 우리는 이미 백엔드가 있으므로 불필요합니다.

## 🎯 핵심 포인트

✅ **올바른 방식 (현재 구현)**:
- google_sign_in 패키지만 사용
- Google Cloud Console에서 OAuth 설정
- 직접 백엔드 API 호출

❌ **불필요한 방식**:
- Firebase 프로젝트 생성
- google-services.json 파일
- Firebase Auth 패키지
- Firebase 백엔드 의존성

**결론**: 백엔드 개발자가 100% 맞습니다! Firebase 없이 Google Cloud Console 설정만으로 충분합니다.
