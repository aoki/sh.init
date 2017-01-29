NAME		:= {{hello}}
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
	@github-release release --user $(OWNER) \
		--repo $(REPOSITORY) --tag v$(VERSION)
	@github-release upload --user $(OWNER) \
		--repo $(REPOSITORY) --tag v$(VERSION) \
		--name "$(NAME)-$(VERSION).tar.gz" \
		--file bin/$(NAME)
	github-release info --user $(OWNER) --repo $(REPOSITORY)

.PHONY: list
list:
	github-release info --user $(OWNER) --repo $(REPOSITORY)
