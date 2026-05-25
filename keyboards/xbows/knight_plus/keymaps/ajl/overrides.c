/* Key Overrides */
/* SHIFT + PGUP => HOME */
const key_override_t pg_up_key_override   = ko_make_basic(MOD_MASK_SHIFT, KC_PGUP, KC_HOME);
/* SHIFT + PGDOWN => END */
const key_override_t pg_down_key_override   = ko_make_basic(MOD_MASK_SHIFT, KC_PGDN, KC_END);

// This globally defines all key overrides to be used
const key_override_t *key_overrides[] = {
	&pg_up_key_override,
	&pg_down_key_override
};
