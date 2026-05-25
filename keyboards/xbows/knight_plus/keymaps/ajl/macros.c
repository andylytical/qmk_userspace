/* https://docs.qmk.fm/feature_macros#using-macros-in-c-keymaps */
/* https://docs.qmk.fm/features/send_string#examples */

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
    case SS_MATCHING_CURLYS:
      if (record->event.pressed) {
        SEND_STRING("{}" SS_TAP(X_LEFT));
      }
      break;
    case SS_MATCHING_PARENS:
      if (record->event.pressed) {
        SEND_STRING("()" SS_TAP(X_LEFT));
      }
      break;
    case SS_MATCHING_SQUARES:
      if (record->event.pressed) {
        SEND_STRING("[]" SS_TAP(X_LEFT));
      }
      break;
  }
  return true;
}
