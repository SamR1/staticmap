include Makefile.config
-include Makefile.custom.config
.SILENT:

clean-all:
	rm -fr $(VENV)
	rm -fr .eggs
	rm -fr *.egg-info
	rm -rf dist/
	rm -rf build/

install:
	$(POETRY) install --only main

install-dev:
	$(POETRY) install

tests:
	$(PYTHON) -m unittest
