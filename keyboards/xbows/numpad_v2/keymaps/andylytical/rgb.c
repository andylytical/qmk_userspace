/* Lighting per layer */
#define _NUMBERS  KC_KP_1 ... KC_KP_DOT
#define _OPERATIONS  KC_KP_SLASH ... KC_KP_ENTER

/* Layer indicator only on keys with configured keycodes */
/* https://docs.qmk.fm/features/rgb_matrix#callbacks */
bool rgb_matrix_indicators_advanced_user(uint8_t led_min, uint8_t led_max) {
  uint8_t layer = get_highest_layer(layer_state);
  /* if (layer > 0) { */
    for (uint8_t row = 0; row < MATRIX_ROWS; ++row) {
      for (uint8_t col = 0; col < MATRIX_COLS; ++col) {
        uint8_t index = g_led_config.matrix_co[row][col];
        uint8_t keycode = keymap_key_to_keycode(layer, (keypos_t){col,row});
        if (index >= led_min && index < led_max && index != NO_LED) {
          switch (keycode) {
            case _NUMBERS:
              rgb_matrix_set_color( index, RGB_GREEN );
              break;
            case _OPERATIONS:
              rgb_matrix_set_color( index, RGB_PURPLE );
              break;
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
  /* } */
  return false;
}
