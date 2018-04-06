#!/usr/bin/env bats

run_command_with_docker() {
  docker run --rm -t ${CUSTOM_DOCKER_RUN_OPTS} \
    "${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}" "$@"
}

setup() {
  export CUSTOM_DOCKER_RUN_OPTS=""
}

@test "We have the image built on the current Dockr Engine" {
	docker image ls | grep "${DOCKER_IMAGE_NAME}" | grep "${DOCKER_IMAGE_TAG}"
}
