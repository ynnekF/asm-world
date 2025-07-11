# Makefile for NASM-based Assembly projects

# === Configurable Section ===

# Project name (name of the final executable)
TARGET  := main

# Source and build directories
SRC_DIR := src
OBJ_DIR := build

# File extension setup
SRC_EXT := asm
OBJ_EXT := o

# Toolchain
ASM     := nasm
LD      := ld

# Flags
ASMFLAGS := -f elf64 -g          # -g includes debug symbols
LDFLAGS  :=                      # Add linker flags if needed

# Source files (all .asm in SRC_DIR)
SRCS := $(wildcard $(SRC_DIR)/*.$(SRC_EXT))

# Object files mapped to OBJ_DIR
OBJS := $(patsubst $(SRC_DIR)/%.$(SRC_EXT), $(OBJ_DIR)/%.$(OBJ_EXT), $(SRCS))

# === Build Rules ===

# Default target
all: $(TARGET)

# Link object files to create the final binary
$(TARGET): $(OBJS)
	@echo "[LD] Linking $@"
	@$(LD) $(LDFLAGS) $^ -o $@

# Assemble each .asm into .o
$(OBJ_DIR)/%.$(OBJ_EXT): $(SRC_DIR)/%.$(SRC_EXT)
	@mkdir -p $(OBJ_DIR)
	@echo "[ASM] Assembling $<"
	@$(ASM) $(ASMFLAGS) $< -o $@

# Clean build artifacts
clean:
	@echo "[CLEAN] Removing build artifacts"
	@rm -rf $(OBJ_DIR) $(TARGET)

# Run the built executable
run: all
	@echo "[RUN] Executing $(TARGET)"
	@./$(TARGET)

# Debug with gdb
debug: all
	@echo "[DEBUG] Launching GDB"
	@gdb ./$(TARGET)

.PHONY: all clean run debug
