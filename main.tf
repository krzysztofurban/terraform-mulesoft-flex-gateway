


locals {
  get_target_id_by_name = [for t in data.anypoint_flexgateway_targets.targets.targets : t.id if t.name == var.target_name][0]
}
data "anypoint_flexgateway_target" "target" {
  id     = [for t in data.anypoint_flexgateway_targets.targets.targets : t.id if t.name == var.target_name][0]
  org_id = var.root_org
  env_id = var.env_id
}

resource "anypoint_apim_flexgateway" "fg" {
  org_id                     = var.root_org
  env_id                     = var.env_id
  asset_group_id             = var.root_org
  asset_id                   = "test-api"
  asset_version              = "1.0.0"
  deployment_target_id       = data.anypoint_flexgateway_target.target.id
  deployment_target_name     = data.anypoint_flexgateway_target.target.name
  deployment_gateway_version = data.anypoint_flexgateway_target.target.version
  deployment_expected_status = "deployed"
  deployment_overwrite       = true
  deployment_type            = "HY"
  endpoint_proxy_uri         = "http://0.0.0.0:8081/"

  routing {
    label = "Env1Route"
    upstreams {
      label  = "Env1"
      weight = 100
    }
    rules {
      methods = ["CONNECT", "DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT", "TRACE"]
      path    = ""
      headers = {
        "Environment" = "Env1"
      }
    }
  }

  routing {
    label = "Env2Route"
    upstreams {
      label  = "Env2"
      weight = 100
    }
    rules {
      methods = ["CONNECT", "DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT", "TRACE"]
      path    = ""
      headers = {
        "Environment" = "Env2"
      }
    }
  }

  upstreams {
    label = "Env1"
    uri   = "https://jsonplaceholder.typicode.com/"
  }
  upstreams {
    label = "Env2"
    uri   = "https://echo.free.beeceptor.com"
  }
}


