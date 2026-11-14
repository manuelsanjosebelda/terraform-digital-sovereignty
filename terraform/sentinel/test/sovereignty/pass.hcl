mock "tfconfig/v2" {
  module {
    source = "../../testdata/mock-tfconfig-v2.sentinel"
  }
}

test {
  rules = {
    main = true
  }
}
