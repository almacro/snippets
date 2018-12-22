from setuptools import setup, find_packages
setup(
    name="bitwise",
    version="0.1",
    install_requiresr=['nose'],
    packages=find_packages(),
    package_dir={'':'src'},
    scripts=["scripts/bits","scripts/bitmask"]
)
