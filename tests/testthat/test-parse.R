context("parse")

tblout_file=file.path('sample-data', 'five', 'tblout')
domtblout_file=file.path('sample-data', 'five', 'domtblout')

empty_tblout_file=file.path('sample-data', 'domainless', 'tblout')
empty_domtblout_file=file.path('sample-data', 'domainless', 'domtblout')
slf_tblout_file_1=file.path('sample-data', 'slf', 'SLF1_tblout.scan')
slf_tblout_file_2=file.path('sample-data', 'slf', 'SLF2_tblout.scan')

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

test_that("partially quoted descriptions do not fail", {
  expect_silent(f1 <- read_tblout(slf_tblout_file_1))
  expect_silent(f2 <- read_tblout(slf_tblout_file_2))
  expect_equal(dim(f1), c(97,19))
  expect_equal(dim(f2), c(97,19))
  expect_equal(f2$description[1], "\"VanR: transcriptional activator regulating VanA, VanH and VanX\" [ARO:3000574]")
})

test_that("hmmprofiles with /f format parse", {
  file = system.file('extdata', 'example.hmmprofile.hmm', package='rhmmer')
  df = read_hmmprofile(file)
  expect_true(nrow(df) == 20)
  expect_true(ncol(df) == 28)
})
