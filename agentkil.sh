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

# TOKEN="bkua_1e6f9444d88326366ee8087ff0a7f52f649bf72a"
# ORG_SLUG="personal-use-4"
# pipeline_slug="sigkill-test"
# number=408

# curl -H "Authorization: Bearer $TOKEN" \
#   -X POST "https://api.buildkite.com/v2/organizations/${ORG_SLUG}/pipelines/${pipeline_slug}/builds/408" 
# #   -H "Content-Type: application/json" \
# #   -d '{
# #     "branch": "main",
# #     "commit": "HEAD",
# #     "message": "Testing all the things :rocket:"
   
# }'


# curl -H "Authorization: Bearer $TOKEN" \
#   -X GET "https://api.buildkite.com/v2/organizations/${ORG_SLUG}/pipelines/${pipeline_slug}/builds/${number}" >> output123.json

#!/bin/bash

API_TOKEN="bkua_1e6f9444d88326366ee8087ff0a7f52f649bf72a"
ORG_SLUG="personal-use-4"
BASE_URL="https://api.buildkite.com/v2/organizations/${ORG_SLUG}"
HEADERS="Authorization: Bearer ${API_TOKEN}"

# # Function to fetch builds
# fetch_builds() {
#     curl -s -H "$HEADERS" "${BASE_URL}/builds"
# }

# # Get current date and date 30 days ago
# end_date=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
# start_date=$(date -u -d "$end_date -30 days" +"%Y-%m-%dT%H:%M:%SZ")

# # Fetch builds and filter active users
# active_users=$(fetch_builds | jq -r --arg start_date "$start_date" --arg end_date "$end_date" '
#     .[] | select(.created_at >= $start_date and .created_at <= $end_date) | .creator.email' | sort | uniq)

# # Count the number of active users
# active_users_count=$(echo "$active_users" | wc -l)

# # Output the result
# echo "Monthly Active Users (MAU): $active_users_count"
# echo "Active Users:"
# echo "$active_users"
#!/bin/bash

# Set your Buildkite API token and organization slug
#!/bin/bash

# Set your Buildkite API token, organization slug, and pipeline slug
BUILDKITE_API_TOKEN="bkua_1e6f9444d88326366ee8087ff0a7f52f649bf72a"
ORGANIZATION_SLUG="personal-use-4"
PIPELINE_SLUG="sigkill-test"

# Function to fetch builds for the pipeline
fetch_builds() {
    curl -s -H "Authorization: Bearer $BUILDKITE_API_TOKEN" \
        "https://api.buildkite.com/v2/organizations/$ORGANIZATION_SLUG/pipelines/$PIPELINE_SLUG/builds?state=failed"
}

# Function to fetch jobs for a build
fetch_jobs() {
    local build_number=$1
    curl -s -H "Authorization: Bearer $BUILDKITE_API_TOKEN" \
        "https://api.buildkite.com/v2/organizations/$ORGANIZATION_SLUG/pipelines/$PIPELINE_SLUG/builds/$build_number/jobs"
}

# Fetch all failed builds for the pipeline
builds=$(fetch_builds)

# Check if builds response is valid JSON
if ! echo "$builds" | jq . > /dev/null 2>&1; then
    echo "Invalid JSON response for builds: $builds"
    exit 1
fi

# Debug: Print the builds response
echo "Builds response: $builds" | jq .

# Loop through each build
echo "$builds" | jq -c '.[]' | while read -r build; do
    build_number=$(echo "$build" | jq -r '.number')
    echo "Fetching jobs for build number: $build_number"

    # Fetch all jobs for the build
    jobs=$(fetch_jobs "$build_number")

    # Check if jobs response is valid JSON
    if ! echo "$jobs" | jq . > /dev/null 2>&1; then
        echo "Invalid JSON response for jobs for build number $build_number: $jobs"
        continue
    fi

    # Debug: Print the jobs response
    echo "Jobs response for build number $build_number: $jobs" | jq .

    # Loop through each job
    echo "$jobs" | jq -c '.[]' | while read -r job; do
        job_state=$(echo "$job" | jq -r '.state')
        exit_code=$(echo "$job" | jq -r '.exit_status')

        # Check if the job failed
        if [ "$job_state" == "failed" ]; then
            job_name=$(echo "$job" | jq -r '.name')
            echo "  Job: $job_name, State: $job_state, Exit Code: $exit_code"
        fi
    done
done