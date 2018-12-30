if __name__ == "__main__":
    import nose
    from recipe26_plugin import *
    nose.run(argv=["", "recipe26", "--with-bdd"], plugins=[BddPrinter()])