NAME		:= hello
VERSION	:= 0.1.0
PUBLISH_TO	:= https://api.github.com/repos/ringohub/sh.init/releases
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
	curl -X POST \
		-H "Accept: application/vnd.github.v3+json" \
		-H "Authorization: token ${SHINIT_GITHUB_TOKEN}" \
		-d '{"tag_name": "v$(VERSION)"}' $(PUBLISH_TO)
	curl -X POST \
		-H "Accept: application/vnd.github.v3+json" \
		-H "Authorization: token ${SHINIT_GITHUB_TOKEN}" \
		--data-binary @dist/$(NAME)-$(VERSION).tar.gz \
		-d '{"Content-Type": "application/gzip"}' $(PUBLISH_TO)/$(RELEASE_ID)/assets?name=$(NAME)-$(VERSION).tar.gz

.PHONY: clean
clean:
	rm dist/*
