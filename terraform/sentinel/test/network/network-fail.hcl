mock "tfplan/v2" {
  module {
    source = "../../testdata/mock-tfplan-network-unsafe.sentinel"
  }
}

test {
  rules = {
    main = false
  }
}
