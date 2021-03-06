NPM_BIN = node_modules/.bin
ENB = $(NPM_BIN)/enb

all: npm build app-dev

# Install npm modules
.PHONY: npm
npm::
	@npm install

# Lint js files
.PHONY: lint
lint::
	@$(NPM_BIN)/jshint-groups
	@$(NPM_BIN)/jscs .

# Build and run tests
.PHONY: test
test:
	$(ENB) make test -n
	$(NPM_BIN)/mocha-phantomjs $(MOCHA_FLAGS) test/test.html

# Build project
.PHONY: build
build:
	mkdir -p build
	YENV=$(YENV) $(ENB) make

# Clean build results
.PHONY: clean
clean:
	$(ENB) make clean

# Create new page
.PHONY: page
page:
	./tools/make-page.sh

# Create new block
.PHONY: block
block:
	./tools/make-block.sh

# Create new rss-block
.PHONY: block-rss
block-rss:
	./tools/make-block-rss.sh

# Run application in development mode
.PHONY: app-dev
app-dev:
	@$(NPM_BIN)/supervisor -w lib -- lib/app.js

.PHONY: deploy
deploy:
	./tools/deploy.sh
