# Compiler and flags
CC = gcc
CFLAGS = -Wall -Wextra -g3
DEBUG_CFLAGS = -Wall -Wextra -g3

# Directories
SRC_DIR = src
DEBUG_DIR = debug
RELEASE_DIR = release

# Source files
SRCS = $(wildcard $(SRC_DIR)/*.c)
OBJS_DEBUG = $(patsubst $(SRC_DIR)/%.c, $(DEBUG_DIR)/src/%.o, $(SRCS))
OBJS_RELEASE = $(patsubst $(SRC_DIR)/%.c, $(RELEASE_DIR)/src/%.o, $(SRCS))

# Executable name
TARGET = atm
DEBUG_TARGET = atm_debug

# Phony targets
.PHONY: all clean

# Default target
all: debug release

# Debug target
debug: $(DEBUG_DIR)/$(DEBUG_TARGET)

$(DEBUG_DIR)/$(DEBUG_TARGET): $(OBJS_DEBUG)
	@echo "Linking: $@"
	$(CC) $(DEBUG_CFLAGS) -o $@ $^

$(DEBUG_DIR)/src/%.o: $(SRC_DIR)/%.c
	@echo "Compiling: $<"
	@mkdir -p $(DEBUG_DIR)/src
	$(CC) $(CFLAGS) -c -o  $@ $<

# Release target
release: $(RELEASE_DIR)/$(TARGET)

$(RELEASE_DIR)/$(TARGET): $(OBJS_RELEASE)
	@echo "Linking: $@"
	$(CC) $(CFLAGS) -o $@ $^

$(RELEASE_DIR)/src/%.o: $(SRC_DIR)/%.c
	@echo "Compiling: $<"
	@mkdir -p $(RELEASE_DIR)/src
	$(CC) $(CFLAGS) -c -o $@ $<

# Clean target
clean:
	@echo "Cleaning..."
	@rm -rf $(DEBUG_DIR)/$(SRC_DIR)/* $(RELEASE_DIR)/$(SRC_DIR)/* $(DEBUG_DIR)/$(DEBUG_TARGET) $(RELEASE_DIR)/$(TARGET)
