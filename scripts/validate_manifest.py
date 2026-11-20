#!/usr/bin/env python3
"""MANDOO Update manifest validation. Python 3.10+ standard library only."""
import json
import re
from pathlib import Path
from urllib.parse import urlsplit

ROOT = Path(__file__).resolve().parents[1]
PATH = ROOT / "docs" / "updates.json"
SLUG = re.compile(r"[a-z][a-z0-9_]{2,63}\Z")
VERSION = re.compile(r"(0|[1-9][0-9]{0,2})\.(0|[1-9][0-9]{0,2})\.(0|[1-9][0-9]{0,2})\Z")
ICLOUD = re.compile(r"/shortcuts/[0-9a-fA-F]{32}\Z")

def valid_icloud(url):
    if not isinstance(url, str) or len(url) > 180:
        return False
    try:
        x = urlsplit(url)
        return (
            x.scheme == "https" and x.hostname == "www.icloud.com"
            and x.port is None and x.username is None and x.password is None
            and x.query == "" and x.fragment == ""
            and ICLOUD.fullmatch(x.path) is not None
        )
    except ValueError:
        return False

def main():
    assert PATH.stat().st_size <= 131072, "manifest too large"
    data = json.loads(PATH.read_text(encoding="utf-8"))
    assert isinstance(data, dict) and data.get("schema") == 1, "schema must be 1"
    entries = data.get("shortcuts")
    assert isinstance(entries, dict), "shortcuts must be an object"
    for slug, value in entries.items():
        assert isinstance(slug, str) and SLUG.fullmatch(slug), f"invalid shortcut ID: {slug!r}"
        assert isinstance(value, dict), f"{slug}: entry must be an object"
        assert value.get("status") in ("preparing", "published"), f"{slug}: invalid status"
        version = value.get("version")
        m = VERSION.fullmatch(version) if isinstance(version, str) else None
        assert m, f"{slug}: invalid version"
        major, minor, patch = map(int, m.groups())
        expected = major * 1000000 + minor * 1000 + patch
        assert type(value.get("version_code")) is int and value["version_code"] == expected, f"{slug}: inconsistent version_code"
        link = value.get("install_url")
        if value["status"] == "published":
            assert valid_icloud(link), f"{slug}: published version requires valid iCloud URL"
        else:
            assert link is None, f"{slug}: preparing version must have null install_url"
        notes = value.get("notes")
        assert isinstance(notes, list) and len(notes) <= 4 and all(isinstance(n, str) and len(n) <= 200 for n in notes), f"{slug}: invalid notes"
        assert value.get("required") is False, f"{slug}: forced updates are disabled"
    print(f"PASS: schema 1, {len(entries)} shortcut(s), versions and links valid")

if __name__ == "__main__":
    main()
