ANYBADGE_VERSION = 1.6.2

IMAGE_NAME ?= anybadge
DOCKERHUB_IMAGE ?= fixl/$(IMAGE_NAME)
GITLAB_IMAGE ?= registry.gitlab.com/fixl/docker-$(IMAGE_NAME)

CI_COMMIT_SHORT_SHA ?= $(shell git rev-parse --short HEAD)
CI_PROJECT_URL ?= $(shell git config --get remote.origin.url)
CI_PIPELINE_URL ?= local

TAG = $(ANYBADGE_VERSION)
TRIVY_COMMAND = docker run --rm -i -v $(shell pwd):/src -w /src -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy:latest

build:
	docker build \
		--pull \
		--build-arg ANYBADGE_VERSION=$(ANYBADGE_VERSION) \
		--build-arg BUILD_DATE=$(shell date -u +"%Y-%m-%dT%H:%M:%SZ") \
		--build-arg VCS_URL=$(CI_PROJECT_URL) \
		--build-arg VCS_REF=$(CI_COMMIT_SHORT_SHA) \
		--build-arg PIPELINE=$(CI_PIPELINE_URL) \
		--tag $(IMAGE_NAME) .

scan:
	if [ ! -f gitlab.tpl ] ; then curl --output gitlab.tpl https://raw.githubusercontent.com/aquasecurity/trivy/master/contrib/gitlab.tpl;  fi

	$(TRIVY_COMMAND) --clear-cache
	$(TRIVY_COMMAND) --exit-code 0 --no-progress --format template --template "@gitlab.tpl" -o gl-container-scanning-report.json $(IMAGE_NAME)
	$(TRIVY_COMMAND) --exit-code 1 --no-progress --severity CRITICAL $(IMAGE_NAME)

publishDockerhub:
	docker tag $(IMAGE_NAME) $(DOCKERHUB_IMAGE)
	docker push $(DOCKERHUB_IMAGE)
	docker tag $(IMAGE_NAME) $(DOCKERHUB_IMAGE):$(TAG)
	docker push $(DOCKERHUB_IMAGE):$(TAG)

publishGitlab:
	docker tag $(IMAGE_NAME) $(GITLAB_IMAGE)
	docker push $(GITLAB_IMAGE)
	docker tag $(IMAGE_NAME) $(GITLAB_IMAGE):$(TAG)
	docker push $(GITLAB_IMAGE):$(TAG)

gitRelease:
	-git tag -d $(TAG)
	-git push origin :refs/tags/$(TAG)
	git tag $(TAG)
	git push origin $(TAG)
	git push
