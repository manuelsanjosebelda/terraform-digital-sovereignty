mock "tfplan/v2" {
  module {
    source = "../../testdata/mock-tfplan-unencrypted.sentinel"
  }
}

test {
  rules = {
    main = false
  }
}