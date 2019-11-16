ANYBADGE_VERSION = 1.5.1

IMAGE_NAME ?= anybadge
DOCKERHUB_IMAGE ?= fixl/$(IMAGE_NAME)
GITLAB_IMAGE ?= registry.gitlab.com/fixl/docker-$(IMAGE_NAME)

TAG = $(ANYBADGE_VERSION)

TRIVY_COMMAND = docker run --rm -i -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy:0.2.1

build:
	docker build \
		--pull \
		--build-arg ANYBADGE_VERSION=$(ANYBADGE_VERSION) \
		--tag $(IMAGE_NAME) .

scan:
	$(TRIVY_COMMAND) --clear-cache --no-progress $(IMAGE_NAME)
	$(TRIVY_COMMAND) --clear-cache --no-progress --exit-code 1 --severity CRITICAL $(IMAGE_NAME)

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
