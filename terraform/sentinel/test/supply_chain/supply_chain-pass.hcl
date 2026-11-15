mock "tfconfig/v2" {
  module {
    source = "../../testdata/mock-tfconfig-supply-chain-pass.sentinel"
  }
}

test {
  rules = {
    main = true
  }
}
