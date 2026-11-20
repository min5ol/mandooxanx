# 🥟 만두양의 단축어 스튜디오

> **2026-11-20 v1.0.2 정식 배포:** 기존 a-Shell 폴더 참조 오류 수정에 더해 실행 전 업데이트 버전 비교값을 조정한 릴리스입니다. [최신 단축어 설치](https://www.icloud.com/shortcuts/3c49c4d0924b4a9798530b2210f3536b) · [변경 내역 및 배포 상태](https://min5ol.github.io/mandooxanx/updates.json). 이전 v1.0.0 공유 링크는 이 저장소에서 더 이상 안내하지 않습니다.


만두양(`@mandooxanx`)의 iOS 단축어 배포·업데이트 서비스입니다.

- **배포 허브 (Notion)**: https://candy-acapella-626.notion.site/41e672d9690b8106a774cee4245980b3
- **YouTube Downloader 안내 (허브에서 선택)**: https://candy-acapella-626.notion.site/41e672d9690b8106a774cee4245980b3
- **업데이트 JSON**: https://min5ol.github.io/mandooxanx/updates.json
- **업데이트 서비스 안내**: https://min5ol.github.io/mandooxanx/

## 구성

| 파일 | 역할 |
| --- | --- |
| `docs/updates.json` | 단축어별 최신 공개 버전, 실제 설치 링크, 변경 내역 |
| `docs/index.html` | GitHub Pages 방문자를 Notion 배포 허브로 안내 |
| `scripts/validate_manifest.py` | JSON 형식, 버전 코드, iCloud URL을 배포 전 검사 |
| `.github/workflows/publish-pages.yml` | PR에서 JSON 검사, main 병합 뒤 GitHub Pages 자동 배포 |

> **현재 공개 버전: v1.0.2.** 최신 iCloud 공유 링크가 `published` 상태로 등록되어 있습니다. 설치 환경은 iPhone + a-Shell mini이며, 사용자 기기별 최초 실행 검증은 별도로 권장합니다.

## 처음 설정할 때

GitHub Pages 배포는 Actions 워크플로를 사용합니다. `main`에 병합되면 검증 후 자동 배포를 시도합니다.

배포가 활성화되지 않았다면 [Settings → Pages](https://github.com/min5ol/mandooxanx/settings/pages)에서 **Build and deployment → Source: GitHub Actions**를 선택한 다음 Actions의 **Validate and publish MANDOO Update**를 다시 실행합니다. Pages 활성화 자체는 코드 검증과 별개입니다.

## 새 버전 배포하기

1. Apple 단축어에서 **새 버전의 실제 공유 링크**를 발급합니다.
2. `docs/updates.json`에서 해당 단축어의 `status`를 `published`로 바꿉니다.
3. `version`, `version_code`, `install_url`, `notes`를 최신 버전으로 수정합니다.
4. 브랜치를 만들어 PR을 열고, JSON 검증을 통과한 뒤 `main`에 병합합니다.
5. GitHub Pages의 JSON이 새 버전을 제공하는지 확인합니다.

버전 코드는 `major * 1,000,000 + minor * 1,000 + patch`를 사용합니다.

예시: `1.0.0` → `1000000`, `1.0.1` → `1000001`.

## 보안과 사용자 경험

- 검증된 `https://www.icloud.com/shortcuts/<32자리 ID>`만 공개합니다.
- 공개 JSON과 설치 링크는 외부에 보이는 값입니다. 개인 키, 토큰, 비밀번호를 절대 넣지 않습니다.
- **자동 확인**과 **무인 자동 설치**는 다릅니다. 설치·기존 단축어 교체에는 사용자의 승인이 필요합니다.
- YouTube Downloader는 **새 다운로드 실행 시 다운로드 작업 전에** 공개 버전을 확인하고, 새 버전이 있으면 설치할지 선택하도록 설계했습니다. 콜백 복귀에는 업데이트 확인을 중복 실행하지 않습니다.
- 설치된 단축어 내 버전 코드·업데이트 분기는 iPhone 실기기에서 별도로 확인해야 합니다.
- 내부 Python 엔진 버전과 사용자 공개 버전은 별도로 관리합니다.

## 다음 단축어 추가

`shortcuts` 객체에 `instagram_downloader`, `tiktok_downloader` 등 실제 배포할 ID를 추가합니다. 각 단축어는 자기 ID만 읽고 다른 앱의 업데이트에는 반응하지 않습니다.

© 2026 만두양
