context("parse")

tblout_file='sample-data/five/tblout'
domtblout_file='sample-data/five/domtblout'

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
