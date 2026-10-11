ifeq ($(strip $(DEVKITARM)),)
$(error "DEVKITARM is not set (use the devkitpro/devkitarm Docker image)")
endif
include $(DEVKITARM)/3ds_rules

TARGET := kirby_arena
ARCH   := -march=armv6k -mtune=mpcore -mfloat-abi=hard -mtp=soft
CFLAGS := -g -Wall -O2 -mword-relocations -ffunction-sections $(ARCH) -D__3DS__ -I$(CTRULIB)/include
LDFLAGS := -specs=3dsx.specs -g $(ARCH)
OBJS := build/main.o

all: $(TARGET).3dsx

build/%.o: source/%.c
	@mkdir -p build
	$(CC) $(CFLAGS) -c $< -o $@

$(TARGET).elf: $(OBJS)
	$(CC) $(LDFLAGS) $^ -L$(CTRULIB)/lib -lctru -lm -o $@

$(TARGET).smdh:
	smdhtool --create "Kirby Arena" "Fan homebrew prototype" "Fan project" $(CTRULIB)/default_icon.png $@

$(TARGET).3dsx: $(TARGET).elf $(TARGET).smdh
	3dsxtool $< $@ --smdh=$(TARGET).smdh

clean:
	rm -rf build *.elf *.3dsx *.smdh
