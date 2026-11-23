# 인스타 미디어 다운로드 v1.0.1 · 배포 준비

**상태: iCloud v1.0.1 최종 공유 링크 발급 전. 이 브랜치는 아직 공개 배포가 아닙니다.**

## 변경 사항

- 개별 스토리 공유 링크에서 같은 계정의 접근 가능한 활성 스토리 탐색
- 현재 스토리만 / 전체 / 원하는 스토리 선택
- 공유 버튼이 없어도 계정명으로 활성 스토리 목록 요청
- 여러 항목의 하이라이트에서 전체 / 선택 다운로드
- a-Shell mini 런처가 기본 공유 폴더 `~shortcuts`에서 불필요하게 `~/Documents`로 이동해 엔진 파일을 찾지 못하는 문제 방지
- 다운로드 엔진 또는 요청 파일이 없으면 `IG-FILE-101`/`IG-FILE-102` 안내
- 기존 릴스 커버, 스토리 음악, 다운로드 진행률, 사진 앱 저장 건수, 원본 날짜 선택 기능 유지
- 일반 게시물의 별도 음악 MP4 변환 미지원 정책 유지

## 설치 본 교체 시 확인

E zone에서 `mdx_instagram_launch.txt` 바로 위 긴 텍스트 액션만 `launcher.sh` 내용으로 교체.
실행 명령은 기존과 동일하게 유지:

```sh
cd ~shortcuts
sed -n '/^#!/,$p' mdx_instagram_launch.txt > mdx_instagram_launch.sh
sh mdx_instagram_launch.sh
```

## 최종 배포 게이트

1. 사용자 아이폰에서 런처 파일 교체 후 정상 실행 확인.
2. `인스타 미디어 다운로드` 단축어 새 iCloud 링크 발급 (기존 v1.0.0 설치 URL 재사용 금지).
3. `docs/updates.json`의 instagram_downloader를 v1.0.1 / 1000001 / 신규 설치 URL로 갱신.
4. README 및 노션 상세 페이지와 허브를 v1.0.1로 갱신.
5. PR CI 검증 후 main 병합, Pages 배포 확인.

기존 v1.0.0 공개 다운로드는 새로운 링크가 발급될 때까지 유지.
