-- Highlight Surrounding Parentheses                ( STATE: Okay, with some issues. )
--  - Only handles highlighting. (I think)
--  - At least okay performance. Much better feeling than `matchparen` or `matchup`.
--      - For good performance, `delay` is still required.
require("sentiment").setup({
	included_buftypes = {
		[""] = true,
	},
	excluded_filetypes = {},
	included_modes = {
		n = true,
		i = true,
	},

	-- Activation (and hiding) Delay  in `ms`.
	--  - NOTE: Before the linger is fixed,
	--          delay at `0` is the only way to avoid flicker and linger.
	--  - But delay `0` is performance issue.
	delay = 24,

	-- Line seach limit.
	--  - Low value is great for performance.
	--      - Counters the delay `0` a bit to gain back performance.
	limit = 32,

	-- NOTE: Both sides of a pair can't have the same character.
	pairs = {
		{ "(", ")" },
		{ "{", "}" },
		{ "[", "]" },
	},
})
