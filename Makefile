MODELS=about game blog gamestate contact
COLLECTIONS=games blogs
ROUTERS=app
VIEWS=about contact blog game blogs games
INIT=main

TEXT=_spec
EXT=coffee

TDIR=spec
ODIR=jslib
DIR=src

DEPS= $(patsubst %, $(DIR)/models/%.$(EXT), $(MODELS)) $(patsubst %, $(DIR)/collections/%.$(EXT), $(COLLECTIONS)) $(patsubst %, $(DIR)/routers/%.$(EXT), $(ROUTERS)) $(patsubst %, $(DIR)/views/%.$(EXT), $(VIEWS)) $(patsubst %, $(DIR)/init/%.$(EXT), $(INIT))
TDEPS= $(patsubst %, $(TDIR)/models/%$(TEXT).$(EXT), $(MODELS)) $(patsubst %, $(TDIR)/collections/%$(TEXT).$(EXT), $(COLLECTIONS)) $(patsubst %, $(TDIR)/routers/%$(TEXT).$(EXT), $(ROUTERS))

.PHONY: test build_tests

development: app_production.js
	@echo "This is just an alias for app_production.js"

test: build_tests
	@mocha \
		--compilers coffee:coffee-script \
		--reporter spec \
		lib/app_spec.coffee

build_tests:
	@cake tests

%.js: $(ODIR)/%.coffee
	coffee -co . $(ODIR)

$(ODIR)/%.js: $(ODIR)/%.coffee
	coffee -co $(ODIR) $(ODIR)

$(ODIR)/app_production.coffee: $(DEPS)
	cake build

$(ODIR)/app_spec.coffee: $(DEPS) $(TDEPS)
	cake tests