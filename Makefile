NAME		:= hello
VERSION	:= v0.1.0

.DEFAULT_GOAL := exec

.PHONY: exec
exec:
	@bin/$(NAME)

.PHONY: publish
publish:
	git tag $(VERSION)
	tar czf bin/$(NAME) dist/$(NAME)-$(VERSION).tar.gz
