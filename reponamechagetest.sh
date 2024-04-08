


# curl -H "Authorization: token $GITHUB_TOKEN" \
# "https://github.com/AthreyaRay/step-update/contents" 

# cat $GITHUB_TOKEN
# curl -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/user

curl -H "Authorization: token $GITHUB_TOKEN" \
-H "Accept: application/vnd.github.v3.raw" \
https://api.github.com/repos/AthreyaRay/step-update/contents/pipeline.yml
