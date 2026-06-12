/* See also: */
/* https://docs.qmk.fm/features/key_overrides */
/* Key Overrides */
/* CTRL + PGUP => HOME */
const key_override_t ctrl_pgup_home =
  ko_make_basic(
    MOD_MASK_CTRL,  // Trigger modifiers: any ctrl
    KC_PGUP,        // Trigger key: page-up
    KC_HOME         // Replacement: home
  );

/* CTRL + PGDOWN => END */
const key_override_t ctrl_pgdown_end =
  ko_make_basic(
    MOD_MASK_CTRL,  // Trigger modifiers: any ctrl
    KC_PGDN,        // Trigger key: page-down
    KC_END          // Replacement: end
  );

/* CTRL + UP => CAPSWORD */
const key_override_t ctrl_up_capsword =
  ko_make_basic(
    MOD_MASK_CTRL,      // Trigger modifiers: any ctrl
    KC_UP,              // Trigger key: page-down
    QK_CAPS_WORD_TOGGLE // Replacement: end
  );

// This globally defines all key overrides to be used
const key_override_t *key_overrides[] = {
	&ctrl_pgup_home,
	&ctrl_pgdown_end,
  &ctrl_up_capsword
};
