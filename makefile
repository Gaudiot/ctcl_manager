.PHONY: prune-branches

prune-branches:
	git fetch --prune
	for branch in $$(git branch -vv | awk '/: gone]/{print $$1}'); do \
		git branch -d $$branch && echo "deleted branch $$branch"; \
	done
	@echo "Deleted all local branches not present on origin."
