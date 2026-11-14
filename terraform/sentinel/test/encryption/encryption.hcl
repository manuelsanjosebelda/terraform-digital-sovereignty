mock "tfplan/v2" {
  module {
    source = "../../testdata/mock-tfplan-encrypted.sentinel"
  }
}

test {
  rules = {
    main = true
  }
}