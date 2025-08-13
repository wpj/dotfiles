# https://gist.github.com/camtheman256/028aa2f1ced68cd435093a2d4680cf88
function fish_jj_prompt --description 'Write out the jj prompt'
    # Is jj installed?
    if not command -sq jj
        return 1
    end

    # Are we in a jj repo?
    if not jj root --quiet &>/dev/null
        return 1
    end

    if test $FISH_JJ_PROMPT_PREFER_GIT
        return 1
    end

    set -l info (jj log 2>/dev/null --no-graph --ignore-working-copy --color=always --revisions @ \
		--template '
			surround(
				"(",
				")",
				separate(commit_summary_separator,
					format_short_change_id_with_hidden_and_divergent_info(self),
					bookmarks,
					tags,
					if(conflict, label("conflict", "×")),
					if(empty, label("empty", "empty"))
				)
			)'
	)

    printf ' %s' $info
end
