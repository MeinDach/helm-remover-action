# helm-remover-action

This is a github that will remove helm charts after PRs get closed.
If the PR gets merged the branch will get deleted as well.

**Attention**: If you delete the branch immediately after merging this Action will not work. (Might be a beta issue)

## Example Workflow
To be able to run this action you need to include a main.Workflow file in the .github folder of the Repo you want to use it.
The Workflow need to be in the master branch to work correctly.

```
workflow "Remove Helm on PR Close" {
  on = "pull_request"
  resolves = ["Remove Helm Chart"]
}

action "Setup Google Cloud" {
  uses = "actions/gcloud/auth@master"
  secrets = ["GCLOUD_AUTH"]
}

action "Remove Helm Chart" {
  needs = ["Setup Google Cloud"]
  uses = "MeinDach/helm-remover-action@master"
  secrets = ["GITHUB_TOKEN"]
  env = {
    GCLOUD_CLUSTER = "mein-cluster"
    GCLOUD_PROJECT = "mein-project"
    GCLOUD_ZONE = "mein-zone"
    REPO_TYPE = "FRONTEND"
  }
}
```

### ENVs
 - REPO_TYPE must be either `FRONTEND` or `BACKEND`

### Secrets
  - GCLOUD_AUTH must be the server.json in base64 encryption
    ```base64 my-server-file-from-gcloud.json```


Further Documents:
[https://help.github.com/articles/about-github-actions/](https://help.github.com/articles/about-github-actions/)