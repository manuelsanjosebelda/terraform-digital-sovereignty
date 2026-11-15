mock "tfplan/v2" {
  module {
    source = "../../testdata/mock-tfplan-instance-rejected.sentinel"
  }
}

test {
  rules = {
    main = false
  }
}
