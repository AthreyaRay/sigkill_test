#!/bin/bash
set -eo pipefail
set -x

step_result=$(build.state)

if [ "$step_result" = "passed" ]; then
    cat <<YAML
steps:
  - command: "echo 'Step has passed'"
notify:
  - slack: "Support_test_account#training-and-testing"
    #   channels:
    #     - "Support_test_account#training-and-testing"
    #   message: "Hello I'm a custom success message"

YAML
else
    cat <<YAML
steps:
  - command: "echo 'It failed'"
notify:
  - slack: "Support_test_account#training-and-testing"
    #   channels:
    #     - "Support_test_account#training-and-testing"
    #   message: "Hello I'm a custom failed message"

YAML
fi