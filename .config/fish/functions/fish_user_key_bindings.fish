function fish_user_key_bindings
	fzf_key_bindings

	# Map <c-p> and <c-n> to cycle history up/down
	bind ctrl-p --mode insert up-or-search
	bind ctrl-p --mode default up-or-search
	bind ctrl-n --mode insert down-or-search
	bind ctrl-n --mode default down-or-search
end
