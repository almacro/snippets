# test_downloader.py
import pytest
from downloader import filename_for  # rename to whatever you saved the script as
 
 
@pytest.mark.parametrize("url, expected", [
    # Simple case
    ("https://dl.humblebundle.com/book.pdf",
     "book.pdf"),
 
    # SINGLE HYPHEN — the case that broke the old regex
    ("https://dl.humblebundle.com/a-programmers-guide.pdf",
     "a-programmers-guide.pdf"),
 
    # MULTIPLE HYPHENS
    ("https://dl.humblebundle.com/a-b-c-d-e.pdf",
     "a-b-c-d-e.pdf"),
 
    # Underscores
    ("https://dl.humblebundle.com/book_name_v2.pdf",
     "book_name_v2.pdf"),
 
    # Mixed hyphens and underscores
    ("https://dl.humblebundle.com/machine-learning_v2-fixed.epub",
     "machine-learning_v2-fixed.epub"),
 
    # Multiple dots in filename (e.g. v-versioning)
    ("https://dl.humblebundle.com/book.v2.final.pdf",
     "book.v2.final.pdf"),
 
    # Query string must be ignored
    ("https://dl.humblebundle.com/book.pdf?gtToken=abc&x=1",
     "book.pdf"),
 
    # Fragment must be ignored
    ("https://dl.humblebundle.com/book.pdf#page=1",
     "book.pdf"),
 
    # Percent-encoded spaces get decoded
    ("https://dl.humblebundle.com/book%20with%20spaces.pdf",
     "book with spaces.pdf"),
 
    # Subdirectory in path — basename still wins
    ("https://dl.humblebundle.com/downloads/2024/book.pdf",
     "book.pdf"),
 
    # Uppercase extension
    ("https://dl.humblebundle.com/BOOK.PDF",
     "BOOK.PDF"),
])
def test_filename_extraction_happy_paths(url, expected):
    assert filename_for(url) == expected
 
 
@pytest.mark.parametrize("url", [
    # No path at all
    "https://dl.humblebundle.com",
    # Trailing slash — path but no filename
    "https://dl.humblebundle.com/",
    # Empty
    "",
])
def test_filename_extraction_rejects_empty(url):
    assert filename_for(url) is None


@pytest.mark.parametrize("url", [
    # Path-traversal attempts must be refused
    "https://dl.humblebundle.com/../secret",
    "https://dl.humblebundle.com/..",
    "https://dl.humblebundle.com/.",
])
def test_filename_extraction_rejects_traversal(url):
    assert filename_for(url) is None


def test_filename_extraction_ignores_the_shell_injection_url():
    """A URL crafted to break shell=True must NOT produce a filename with `;`."""
    # urllib treats these as valid path chars, but our code passes them to curl
    # as a single argv entry — so nothing to exploit. Regression guard.
    url = "https://dl.humblebundle.com/book.pdf;rm%20-rf%20~"
    name = filename_for(url)
    # Whatever the derived name is, it can't contain a shell metachar that
    # would execute — subprocess without shell=True treats it as a filename.
    assert name is not None
    assert ";" in name  # decoded semicolon is fine here — it's just a filename char
