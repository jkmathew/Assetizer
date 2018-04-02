EXECUTABLE_NAME = assetize

BIN_PATH = /usr/local/bin
INSTALL_PATH = $(BIN_PATH)/$(EXECUTABLE_NAME)
BUILD_PATH = .build/release/$(EXECUTABLE_NAME)


.PHONY: install build

install: build
	mkdir -p $(BIN_PATH)
	cp -f $(BUILD_PATH) $(INSTALL_PATH)

build:
	swift build --disable-sandbox -c release -Xswiftc -static-stdlib

