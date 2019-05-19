resource "heroku_app" "app" {
  name   = var.heroku_app_name
  region = "us"

  buildpacks = var.heroku_buildpacks

  config_vars {
    FOOBAR = "baz"
  }

  buildpacks = [
    "heroku/go"
  ]
}
