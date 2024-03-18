#!/bin/bash
set -x
# Identify all Buildkite agent processes
AGENT_PIDS=$(pgrep buildkite-agent)

# Loop through each PID and send a SIGTERM for a graceful shutdown
for PID in $AGENT_PIDS; do
    echo "Sending SIGTERM to Buildkite Agent PID: $PID"
    kill -SIGTERM "$PID"
done

echo "All Buildkite Agents have been signaled to shut down gracefully."

