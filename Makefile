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

.PHONY: clean
clean:
	rm dist/*
