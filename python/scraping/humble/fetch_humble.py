'''1. save humble order page ("Thanks for purchasing ...") to "book.html",
2. filter the cdn links with:
  grep cdn book.html | grep -Po 'href="\K[^"]+' | grep -E 'pdf|epub|zip' > LINKS
3. fetch the books with:
  python3 fetch_humble.py LINKS
'''
import re
import subprocess
import sys

from pathlib import PurePosixPath
from urllib.parse import urlparse

if len(sys.argv) < 2:
    print('ERROR no input file')
    print(f'usage: {sys.argv[0]} urlfile')
    sys.exit(1)


file_path = sys.argv[1]
with open(file_path, 'r') as file:
    urls = [line.strip() for line in file.readlines()]


for url in urls:
    #print(url)                                                                 
    parsed_url = urlparse(url)
    book = PurePosixPath(parsed_url.path).name
    subprocess.run([f"curl -kL -o {book} '{url}'"], shell=True)
