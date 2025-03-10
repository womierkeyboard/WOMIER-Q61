// Copyright 2025 QMK
// SPDX-License-Identifier: GPL-2.0-or-later

/*******************************************************************************
  88888888888 888      d8b                .d888 d8b 888               d8b
      888     888      Y8P               d88P"  Y8P 888               Y8P
      888     888                        888        888
      888     88888b.  888 .d8888b       888888 888 888  .d88b.       888 .d8888b
      888     888 "88b 888 88K           888    888 888 d8P  Y8b      888 88K
      888     888  888 888 "Y8888b.      888    888 888 88888888      888 "Y8888b.
      888     888  888 888      X88      888    888 888 Y8b.          888      X88
      888     888  888 888  88888P'      888    888 888  "Y8888       888  88888P'
                                                        888                 888
                                                        888                 888
                                                        888                 888
     .d88b.   .d88b.  88888b.   .d88b.  888d888 8888b.  888888 .d88b.   .d88888
    d88P"88b d8P  Y8b 888 "88b d8P  Y8b 888P"      "88b 888   d8P  Y8b d88" 888
    888  888 88888888 888  888 88888888 888    .d888888 888   88888888 888  888
    Y88b 888 Y8b.     888  888 Y8b.     888    888  888 Y88b. Y8b.     Y88b 888
     "Y88888  "Y8888  888  888  "Y8888  888    "Y888888  "Y888 "Y8888   "Y88888
         888
    Y8b d88P
     "Y88P"
*******************************************************************************/

#include QMK_KEYBOARD_H

#ifdef RGB_MATRIX_ENABLE
#include "rgb_matrix.h"
__attribute__ ((weak)) led_config_t g_led_config = {
  {
    { 0, NO_LED, NO_LED, NO_LED, NO_LED, NO_LED, NO_LED, NO_LED, NO_LED, NO_LED, NO_LED, NO_LED, NO_LED, NO_LED, NO_LED, NO_LED },
    { NO_LED, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, NO_LED, NO_LED },
    { 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, NO_LED, NO_LED },
    { 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, NO_LED, 40, NO_LED, NO_LED },
    { 41, NO_LED, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, NO_LED, NO_LED },
    { 54, 55, 56, NO_LED, NO_LED, 57, NO_LED, NO_LED, NO_LED, 58, 59, 60, 61, 62, NO_LED, NO_LED },
  },
  { {0, 10}, {16, 10}, {32, 10}, {48, 10}, {64, 10}, {80, 10}, {96, 10}, {112, 10}, {128, 10}, {144, 10}, {160, 10}, {176, 10}, {192, 10}, {220, 10}, {4, 20}, {24, 20}, {40, 20}, {56, 20}, {72, 20}, {88, 20}, {104, 20}, {120, 20}, {136, 20}, {152, 20}, {168, 20}, {184, 20}, {200, 20}, {222, 20}, {4, 30}, {28, 30}, {44, 30}, {60, 30}, {76, 30}, {92, 30}, {108, 30}, {124, 30}, {140, 30}, {156, 30}, {172, 30}, {188, 30}, {216, 30}, {8, 40}, {35, 40}, {51, 40}, {67, 40}, {83, 40}, {99, 40}, {115, 40}, {131, 40}, {147, 40}, {163, 40}, {180, 40}, {208, 40}, {224, 40}, {0, 50}, {20, 50}, {40, 50}, {110, 50}, {160, 50}, {176, 50}, {192, 50}, {208, 40}, {224, 40}, {225, 65}, {225, 65}, {225, 65} },
  { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
};
#endif
#ifdef MATRIX_MASKED
__attribute__((weak)) const matrix_row_t matrix_mask[] = {
    0b0000000000000001,
    0b0011111111111110,
    0b0011111111111111,
    0b0010111111111111,
    0b0011111111111101,
    0b0011111000100111,
};
#endif
