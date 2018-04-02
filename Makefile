EXECUTABLE_NAME = Run

INSTALL_PATH = /usr/local/bin/$(EXECUTABLE_NAME)
BUILD_PATH = .build/release/$(EXECUTABLE_NAME)


.PHONY: install build

install: build
	mkdir -p $(PREFIX)/bin
	cp -f $(BUILD_PATH) $(INSTALL_PATH)

build:
	swift build --disable-sandbox -c release -Xswiftc -static-stdlib

