context("parse")

tblout_file='sample-data/five/tblout'
domtblout_file='sample-data/five/domtblout'

empty_tblout_file='sample-data/domainless/tblout'
empty_domtblout_file='sample-data/domainless/domtblout'

test_that("read_tblout works", {
  tblout <- read_tblout(tblout_file)
  expect_silent(read_tblout(tblout_file))
  expect_equal(dim(tblout), c(37,19))
})

test_that("read_domtblout works", {
  domtblout <- read_domtblout(domtblout_file)
  expect_silent(read_domtblout(domtblout_file))
  expect_equal(dim(domtblout), c(70,23))
})

test_that("using the wrong reader fails", {
  expect_warning(read_domtblout(tblout_file))
  expect_warning(read_tblout(domtblout_file))
})

test_that("files with no data do not fail", {
  expect_silent(read_domtblout(empty_tblout_file))
  expect_silent(read_tblout(empty_domtblout_file))
  expect_equal(dim(read_tblout(empty_tblout_file)), c(0,19))
  expect_equal(dim(read_domtblout(empty_domtblout_file)), c(0,23))
})
