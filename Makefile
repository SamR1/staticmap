include Makefile.config
-include Makefile.custom.config
.SILENT:

clean:
	rm -fr .mypy_cache
	rm -fr .ruff_cache
	rm -fr .staticmap_cache

clean-all: clean
	rm -fr $(VENV)
	rm -fr .eggs
	rm -fr *.egg-info
	rm -rf dist/
	rm -rf build/

checks: lint type-check tests

format:
	$(RUFF) format staticmap3

fix:
	$(RUFF) format staticmap3
	$(RUFF) check --fix staticmap3

install:
	$(POETRY) install --only main

install-dev:
	$(POETRY) install --all-extras

lint:
	$(RUFF) check staticmap3

tests:
	$(PYTHON) -m unittest

type-check:
	echo 'Running mypy...'
	$(MYPY) staticmap3 $(MYPY_ARGS)
