// Milestone 2 placeholder: moves a "K" with the Circle Pad. START exits.
#include <3ds.h>
#include <stdio.h>

int main(void) {
    gfxInitDefault();
    consoleInit(GFX_TOP, NULL);

    int x = 25, y = 15;
    while (aptMainLoop()) {
        hidScanInput();
        if (hidKeysDown() & KEY_START) break;

        circlePosition cp;
        hidCircleRead(&cp);
        if (cp.dx > 30 && x < 48) x++;
        if (cp.dx < -30 && x > 1) x--;
        if (cp.dy > 30 && y > 3) y--;
        if (cp.dy < -30 && y < 28) y++;

        consoleClear();
        printf("\x1b[1;1HKirby Arena - prototype (M2)");
        printf("\x1b[2;1HCircle Pad: move   START: exit");
        printf("\x1b[%d;%dHK", y, x);

        gfxFlushBuffers();
        gfxSwapBuffers();
        gspWaitForVBlank();
    }
    gfxExit();
    return 0;
}
