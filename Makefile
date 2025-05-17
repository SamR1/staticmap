include Makefile.config
-include Makefile.custom.config
.SILENT:

clean:
	rm -fr .mypy_cache
	rm -fr .ruff_cache

clean-all: clean
	rm -fr $(VENV)
	rm -fr .eggs
	rm -fr *.egg-info
	rm -rf dist/
	rm -rf build/

checks: lint type-check tests

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

type-check:
	echo 'Running mypy...'
	$(MYPY) staticmap $(MYPY_ARGS)
