.PHONY: prune-branches

prune-branches:
	git fetch --prune
	for branch in $$(git branch -vv | awk '/: gone]/{print $$1}'); do \
		git branch -d $$branch; \
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

gen-launcher-icons:
	flutter pub run flutter_launcher_icons
	@if [ -f android/app/src/main/res/mipmap-mdpi/ic_launcher.png ] && [ -f android/app/src/main/res/mipmap-hdpi/ic_launcher.png ] && [ -f android/app/src/main/res/mipmap-xhdpi/ic_launcher.png ] && [ -f android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png ] && [ -f android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png ]; then \
		echo "Launcher icons generated successfully."; \
	else \
		echo "Failed to generate launcher icons."; \
		exit 1; \
	fi
