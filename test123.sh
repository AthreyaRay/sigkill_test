#!/bin/bash
set -eo pipefail
set -x

step_result=$(BUILDKITE_BUILD_STATUS)

if [ "$step_result" = "passed" ]; then
    cat <<YAML
steps:
  - command: "echo 'Step has passed'"
    
notify:
    - slack:
        channels:
            - "Support_test_account#training-and-testing"
        message: "Hello I'm a custom success message"
YAML
else
    cat <<YAML
steps:
  - command: "echo 'It failed'"
    
notify:
    - slack:
        channels:
            - "Support_test_account#training-and-testing"
        message: "Hello I'm a custom success message"

YAML
fi