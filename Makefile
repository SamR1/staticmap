include Makefile.config
-include Makefile.custom.config
.SILENT:

clean-all:
	rm -fr $(VENV)
	rm -fr .eggs
	rm -fr *.egg-info
	rm -rf dist/
	rm -rf build/

format:
	$(RUFF) format staticmap

fix:
	$(RUFF) format staticmap
	$(RUFF) check --fix staticmap

install:
	$(POETRY) install --only main

install-dev:
	$(POETRY) install

lint:
	$(RUFF) check staticmap

tests:
	$(PYTHON) -m unittest
