# 인스타 미디어 다운로드 v1.0.1 · 배포 준비

**상태: v1.0.1 정식 공개 (2026-11-23).**

- iCloud 설치: https://www.icloud.com/shortcuts/397ab1e23dee447aa1a229f4bf04daef
- 공개 버전 코드: `1000001`

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

## 배포 기록

- 새 iCloud v1.0.1 공유 링크 연결
- GitHub Pages: `docs/updates.json`의 Instagram 공개 버전 1.0.1 갱신
- 노션 상세 페이지와 배포 허브에 기능 안내 및 오류 해결 안내 반영
- GitHub PR #13 검증 후 병합, Pages 자동 배포

기존 v1.0.0은 배포 이력으로만 유지하며 새 설치는 v1.0.1을 사용합니다.
