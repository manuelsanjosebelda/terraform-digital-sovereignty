
mock "tfconfig/v2" {
  module {
    source = "../../testdata/mock-tfconfig-v2-fail.sentinel"
  }
}

test {
  rules = {
    main = false
  }
}
