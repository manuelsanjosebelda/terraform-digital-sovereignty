mock "tfconfig/v2" {
  module {
    source = "../../testdata/mock-tfconfig-supply-chain-fail.sentinel"
  }
}

test {
  rules = {
    main = false
  }
}
