context("parse")

test_that("read_tblout works", {
  tblout <- read_tblout('sample-data/five/tblout')
  expect_equal(ncol(tblout), 19)
})

test_that("read_domtblout works", {
  domtblout <- read_domtblout('sample-data/five/domtblout')
  expect_equal(ncol(domtblout), 23)
})

# test_that("using the wrong reader fails", {
#   expect_error(read_domtblout('sample-data/five/tblout'))
#   expect_error(read_tblout('sample-data/five/domtblout'))
# })
