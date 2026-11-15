mock "tfplan/v2" {
  module {
    source = "../../testdata/mock-tfplan-network-safe.sentinel"
  }
}

test {
  rules = {
    main = true
  }
}
