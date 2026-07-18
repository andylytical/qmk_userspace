/* See also: */
/* https://docs.qmk.fm/features/key_overrides */
/* Key Overrides */

/* CTRL + PGUP => HOME */
/* const key_override_t ctrl_pgup_home = */
/*   ko_make_basic( */
/*     MOD_MASK_CTRL,  // Trigger modifiers: any ctrl */
/*     KC_PGUP,        // Trigger key: page-up */
/*     KC_HOME         // Replacement: home */
/*   ); */

/* CTRL + PGDOWN => END */
/* const key_override_t ctrl_pgdown_end = */
/*   ko_make_basic( */
/*     MOD_MASK_CTRL,  // Trigger modifiers: any ctrl */
/*     KC_PGDN,        // Trigger key: page-down */
/*     KC_END          // Replacement: end */
/*   ); */

/* CTRL + UP => CAPSWORD */
/* const key_override_t ctrl_up_capsword = */
/*   ko_make_basic( */
/*     MOD_MASK_CTRL,      // Trigger modifiers: any ctrl */
/*     KC_UP,              // Trigger key: page-down */
/*     QK_CAPS_WORD_TOGGLE // Replacement: end */
/*   ); */

/* ALT + V => Mouse Button 3 */
const key_override_t alt_v_mouse3 =
  ko_make_basic(
    MOD_MASK_ALT,       // Trigger modifiers: any alt
    KC_V,               // Trigger key: page-down
    MS_BTN3             // Replacement: mouse button 3
  );

/* CTRL + SHIFT + 4 => Mouse Wheel Down */
const key_override_t ctl_shft_4_mswheeldown =
  ko_make_basic(
    MOD_MASK_CS,        // Trigger modifiers: any ctrl + shft
    KC_4,               // Trigger key: 4
    MS_WHLD             // Replacement: mouse wheel down
  );

/* CTRL + SHIFT + 2 => Mouse Wheel Up */
const key_override_t ctl_shft_2_mswheelup =
  ko_make_basic(
    MOD_MASK_CS,        // Trigger modifiers: any ctrl + shft
    KC_2,               // Trigger key: 2
    MS_WHLU             // Replacement: mouse wheel up
  );

// This globally defines all key overrides to be used
const key_override_t *key_overrides[] = {
	&alt_v_mouse3,
	&ctl_shft_4_mswheeldown,
  &ctl_shft_2_mswheelup
};
