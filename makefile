.PHONY: prune-branches

prune-branches:
	git fetch --prune
	for branch in $$(git branch -vv | awk '/: gone]/{print $$1}'); do \
		git branch -d $$branch && echo "deleted branch $$branch"; \
	done
	@echo "Deleted all local branches not present on origin."

gen-strings:
	flutter gen-l10n
	@if [ -f lib/l10n/untranslated_messages.txt ] && [ "$$(cat lib/l10n/untranslated_messages.txt | tr -d '[:space:]')" = "{}" ]; then \
		rm lib/l10n/untranslated_messages.txt; \
		echo "File lib/l10n/untranslated_messages.txt removed because it was empty (only {})."; \
	else \
		echo "Missing translations found"; \
		exit 1; \
	fi
