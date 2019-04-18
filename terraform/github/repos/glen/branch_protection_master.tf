resource "github_branch_protection" "master" {
  repository     = "${ github_repository.repo.name }"
  branch         = "master"
  enforce_admins = true
}
