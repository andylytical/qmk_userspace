/* Lighting per layer */
#define _LETTERS  KC_A ... KC_Z
#define _NUMBERS  KC_1 ... KC_0
#define _F_KEYS  KC_F1 ... KC_F12
/* MODIFIER_KEYCODE_RANGE already defined in keycodes.h */

/* Layer indicator only on keys with configured keycodes */
/* https://docs.qmk.fm/features/rgb_matrix#callbacks */
bool rgb_matrix_indicators_advanced_user(uint8_t led_min, uint8_t led_max) {
  uint8_t layer = get_highest_layer(layer_state);
  if (layer > 0) {
    for (uint8_t row = 0; row < MATRIX_ROWS; ++row) {
      for (uint8_t col = 0; col < MATRIX_COLS; ++col) {
        uint8_t index = g_led_config.matrix_co[row][col];
        uint8_t keycode = keymap_key_to_keycode(layer, (keypos_t){col,row});
        if (index >= led_min && index < led_max && index != NO_LED) {
          switch (keycode) {
            case _LETTERS:
              rgb_matrix_set_color( index, RGB_MAGENTA );
              break;
            case _NUMBERS:
              rgb_matrix_set_color( index, RGB_CYAN );
              break;
            case _F_KEYS:
              rgb_matrix_set_color( index, RGB_GREEN );
              break;
            /* case AUDIO_KEYCODE_RANGE: */
            /*   rgb_matrix_set_color( index, RGB_GOLD ); */
            /*   break; */
            /* case RGB_MATRIX_KEYCODE_RANGE: */
            /*   rgb_matrix_set_color( index, RGB_YELLOW ); */
            /*   break; */
            default:
              if ( keycode > KC_TRNS ) {
                rgb_matrix_set_color(index, RGB_RED);
              } else {
                rgb_matrix_set_color(index, RGB_OFF);
              }
          }
        }
      }
    }
  }
  return false;
}
