mock "tfplan/v2" {
  module {
    source = "../../testdata/mock-tfplan-instance-approved.sentinel"
  }
}

test {
  rules = {
    main = true
  }
}
