[![Travis-CI Build Status](https://travis-ci.org/arendsee/rhmmer.svg?branch=master)](https://travis-ci.org/arendsee/rhmmer)
[![Coverage Status](https://img.shields.io/codecov/c/github/arendsee/rhmmer/master.svg)](https://codecov.io/github/arendsee/rhmmer?branch=master)

# rhmmer

[HMMER](hmmer.ord) is a powerful package for profile HMM analysis. If you want
to interface with the web server through R, for example to search for domains
in a small number of proteins, consider using the Bio3D package.`rhmmer` is
specifically designed for working with the standalone HMMer tool.

What `rhmmer` does do

 * parse HMMER output into tidy data frames

What `rhmmer` may do in the future

 * provide simple wrappers for calling some of the HMMER functions (although,
   if you are doing anything high-throughput, it might be easier to use
   a shellscript on a cluster)

 * check HMMER version

 * download PFAM databases for you

What `rhmmer` will never do

 * interface with the HMMER web server (use Bio3D)

 * install HMMER for you (that is your problem)
