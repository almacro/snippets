if __name__ == "__main__":
    import doctest
    from glob import glob
    for file in glob("recipe27_s*.doctest"):
        print ("Running tests found in %s" % file)
        doctest.testfile(file)