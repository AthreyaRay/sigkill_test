#!/bin/bash
# set -x
# # Identify all Buildkite agent processes
# AGENT_PIDS=$(pgrep buildkite-agent)

# # Loop through each PID and send a SIGTERM for a graceful shutdown
# for PID in $AGENT_PIDS; do
#     echo "Sending SIGTERM to Buildkite Agent PID: $PID"
#     kill -SIGTERM "$PID"
# done

# echo "All Buildkite Agents have been signaled to shut down gracefully."

TOKEN="bkua_1e6f9444d88326366ee8087ff0a7f52f649bf72a"
ORG_SLUG="personal-use-4"
pipeline_slug="sigkill-test"
number=408

# curl -H "Authorization: Bearer $TOKEN" \
#   -X POST "https://api.buildkite.com/v2/organizations/${ORG_SLUG}/pipelines/${pipeline_slug}/builds/408" 
# #   -H "Content-Type: application/json" \
# #   -d '{
# #     "branch": "main",
# #     "commit": "HEAD",
# #     "message": "Testing all the things :rocket:"
   
# }'


curl -H "Authorization: Bearer $TOKEN" \
  -X GET "https://api.buildkite.com/v2/organizations/${ORG_SLUG}/pipelines/${pipeline_slug}/builds/${number}" >> output123.json
