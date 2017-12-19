[![Travis-CI Build Status](https://travis-ci.org/arendsee/rhmmer.svg?branch=master)](https://travis-ci.org/arendsee/rhmmer)
[![Coverage Status](https://img.shields.io/codecov/c/github/arendsee/rhmmer/master.svg)](https://codecov.io/github/arendsee/rhmmer?branch=master)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/rhmmer)](https://cran.r-project.org/package=rhmmer)

# rhmmer

[HMMER](hmmer.ord) is a powerful package for profile HMM analysis. If you want
to interface with the web server through R, for example to search for domains
in a small number of proteins, consider using the Bio3D package.`rhmmer` is
specifically designed for working with the standalone HMMer tool.

## Installation

To install the github version

```R
library(devtools)
install_github('arendsee/rhmmer')
```

## Examples

`rhmmer` currently exports exactly two functions: `read_domtblout` and
`read_tblout`. These read the `hmmscan` outputs specified by the `--domtblout`
and `--tblout` arguments, respectively.

```R
domtblout <- system.file('extdata', 'example.domtblout.txt', package='rhmmer')
read_domtblout(domtblout)
```

```R
tblout <- system.file('extdata', 'example.tblout.txt', package='rhmmer')
read_tblout(tblout)
```

## What `rhmmer` does and doesn't

What `rhmmer` currently does

 * parse HMMER output (tblout and domtblout) into tidy data frames

What `rhmmer` may do in the future

 * provide simple wrappers for calling some of the HMMER functions (although,
   if you are doing anything high-throughput, it might be easier to use
   a shellscript on a cluster)

 * parse metadata from the comments in HMMER output files

 * read pfamtblout and the raw output (with alignments)

 * read the HMM models

 * download databases for you (e.g. PFAM)

 * access precompiled PFAM results

What `rhmmer` will never do

 * interface with the HMMER web server (use Bio3D)

 * install HMMER for you (that is your problem)

 * duplicate the whole HMMER api (just use the CLI tool)
