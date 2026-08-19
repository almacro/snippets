#!/usr/bin/env python3
"""Download files listed one URL per line."""
import os
import subprocess
import sys
from urllib.parse import urlparse, unquote
 
 
def filename_for(url: str) -> str | None:
    """Return a safe local filename for `url`, or None if we can't derive one.
 
    Uses the last path segment before the query string, percent-decoded.
    Rejects anything with a path separator or that resolves outside cwd.
    """
    path = urlparse(url).path
    if not path or path.endswith("/"):
        return None
    name = unquote(os.path.basename(path))
    # Refuse path-traversal attempts and separators.
    if not name or name in {".", ".."} or "/" in name or "\\" in name:
        return None
    return name
 
 
def download(url: str, dest: str) -> int:
    """Fetch `url` into `dest`. Returns curl's exit code."""
    # No shell=True: args go through argv, so `;` and friends can't escape.
    result = subprocess.run(
        ["curl", "-L", "--fail", "--silent", "--show-error", "-o", dest, url],
    )
    return result.returncode
 
 
def main(argv: list[str]) -> int:
    if len(argv) < 2:
        print(f"usage: {argv[0]} urlfile", file=sys.stderr)
        return 1
    with open(argv[1], "r", encoding="utf-8") as f:
        urls = [line.strip() for line in f if line.strip() and not line.startswith("#")]
 
    failures = 0
    for url in urls:
        name = filename_for(url)
        if name is None:
            print(f"SKIP {url} — could not derive filename", file=sys.stderr)
            failures += 1
            continue
        rc = download(url, name)
        if rc != 0:
            print(f"FAIL {url} — curl exit {rc}", file=sys.stderr)
            failures += 1
        else:
            print(f"OK   {name}")
    return 0 if failures == 0 else 2
 
 
if __name__ == "__main__":
    sys.exit(main(sys.argv))

