resource "volterra_virtual_site" "vs" {
  name      = format("%s-zug1", var.project_prefix)
  namespace = "shared"

  site_selector {
    expressions = [format("ves.io/siteName in (%s-zug1)", var.project_prefix)]
  }

  site_type = "CUSTOMER_EDGE"

}

