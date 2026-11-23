#!/bin/sh
# MANDOO STUDIO · 인스타 미디어 다운로드 v1.0.1
# 2026-11-23: Fix false missing-engine errors from directory switching.
# Execute Command has already run `cd ~shortcuts`. Keep that directory.
# Do not print cookies, Instagram URLs, or the request Base64.

# a-Shell Put File and Execute Command normally use the same ~shortcuts dir.
# Only recover if the caller started this script outside that directory.
if [ ! -s mdx_instagram_engine.txt ] || [ ! -s mdx_instagram_request.txt ]; then
    if [ -n "${SHORTCUTS:-}" ] && [ -s "$SHORTCUTS/mdx_instagram_engine.txt" ] && [ -s "$SHORTCUTS/mdx_instagram_request.txt" ]; then
        cd "$SHORTCUTS" || exit 2
    elif [ -n "${GROUP:-}" ] && [ -s "$GROUP/mdx_instagram_engine.txt" ] && [ -s "$GROUP/mdx_instagram_request.txt" ]; then
        cd "$GROUP" || exit 2
    fi
fi

if [ ! -s mdx_instagram_engine.txt ]; then
    printf '\n[IG-FILE-101] 인스타 다운로드 엔진 파일을 찾지 못했어요.\n'
    printf '단축어의 Python 코드 아래 「이름 설정: mdx_instagram_engine.txt」와 a-Shell mini 「Put File」 연결을 확인해 주세요.\n'
    printf 'a-Shell mini 앱을 한 번 실행한 뒤 단축어를 다시 실행해 주세요.\n'
    exit 2
fi
if [ ! -s mdx_instagram_request.txt ]; then
    printf '\n[IG-FILE-102] 다운로드 요청 파일을 찾지 못했어요.\n'
    printf '단축어의 「이름 설정: mdx_instagram_request.txt」와 a-Shell mini 「Put File」 연결을 확인해 주세요.\n'
    exit 2
fi

mkdir -p mdx_instagram/mdx_jobs mdx_instagram/mdx_auth || exit 2

# Put File may prefix the text with a synthetic line; preserve known behavior.
tail -n +2 mdx_instagram_engine.txt > mdx_instagram_engine.py || exit 2
if [ ! -s mdx_instagram_engine.py ]; then
    printf '\n[IG-FILE-103] 전달된 엔진 내용이 비어 있습니다. 단축어의 Python 텍스트 전체를 다시 확인해 주세요.\n'
    exit 2
fi

if [ ! -f mdx_instagram/mdx_dependencies_v1.ok ]; then
    echo '인스타 다운로드 실행 환경 준비 중…'
    python3 -m pip install --disable-pip-version-check --quiet instaloader gallery-dl piexif || exit 3
    touch mdx_instagram/mdx_dependencies_v1.ok
fi

# Request is transferred as a file, not exposed in the terminal command.
mdx_request="$(tail -n 1 mdx_instagram_request.txt)"
rm -f mdx_instagram_request.txt
if [ -z "$mdx_request" ]; then
    printf '\n[IG-FILE-104] 다운로드 요청이 비어 있습니다. 다시 실행해 주세요.\n'
    exit 4
fi

rm -f mdx_instagram/mdx_return.sh
python3 -u mdx_instagram_engine.py "$mdx_request"
mdx_exit=$?

if [ -f mdx_instagram/mdx_return.sh ]; then
    sh mdx_instagram/mdx_return.sh
else
    printf '\n[IG-CALLBACK-105] 실행 결과를 단축어에 전달하지 못했어요. (종료 코드 %s)\n' "$mdx_exit"
fi
