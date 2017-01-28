NAME		:= hello
VERSION	:= 0.1.0
OWNER		:= ringohub
REPOSITORY	:= sh.init

.DEFAULT_GOAL := exec

.PHONY: exec
exec:
	@bin/$(NAME)

.PHONY: publish
publish:
	git tag v$(VERSION)
	@mkdir -p dist
	tar cvzf dist/$(NAME)-$(VERSION).tar.gz bin/$(NAME)
	@github-release release --user $(OWNER) \
		--repo $(REPOSITORY) --tag v$(VERSION)
	@github-release upload --user $(OWNER) \
		--repo $(REPOSITORY) --tag v$(VERSION) \
		--name "$(NAME)-$(VERSION).tar.gz" \
		--file dist/$(NAME)-$(VERSION).tar.gz
	github-release info --user $(OWNER) --repo $(REPOSITORY)

.PHONY: list
list:
	github-release info --user $(OWNER) --repo $(REPOSITORY)

.PHONY: clean
clean:
	rm dist/*
