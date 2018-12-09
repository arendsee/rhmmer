[![Travis-CI Build Status](https://travis-ci.org/arendsee/rhmmer.svg?branch=master)](https://travis-ci.org/arendsee/rhmmer)
[![Coverage Status](https://img.shields.io/codecov/c/github/arendsee/rhmmer/master.svg)](https://codecov.io/github/arendsee/rhmmer?branch=master)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/rhmmer)](https://cran.r-project.org/package=rhmmer)
[![CRAN downloads](http://cranlogs.r-pkg.org/badges/rhmmer)](http://cran.rstudio.com/web/packages/rhmmer/index.html)
[![total downloads](http://cranlogs.r-pkg.org/badges/grand-total/rhmmer)](http://cranlogs.r-pkg.org/badges/grand-total/rhmmer)
[![DOI](https://zenodo.org/badge/114339623.svg)](https://zenodo.org/badge/latestdoi/114339623)

# rhmmer

[HMMER](http://hmmer.org) is a powerful package for profile HMM analysis. If
you want to interface with the web server through R, for example to search for
domains in a small number of proteins, consider using the Bio3D
package.`rhmmer` is specifically designed for working with the standalone HMMER
tool.

## Installation

`rhmmer` is available on CRAN


```r
install.packages('rhmmer')
```

Alternatively, you may install the github development version


```r
library(devtools)
install_github('arendsee/rhmmer')
```

## Examples

`rhmmer` currently exports exactly two functions: `read_domtblout` and
`read_tblout`. These read the `hmmscan` outputs specified by the `--domtblout`
and `--tblout` arguments, respectively.

The `domtblout` files have the format:

```
#                                                                            --- full sequence --- -------------- this domain -------------   hmm coord   ali coord   env coord
# target name        accession   tlen query name           accession   qlen   E-value  score  bias   #  of  c-Evalue  i-Evalue  score  bias  from    to  from    to  from    to  acc description of target
#------------------- ---------- ----- -------------------- ---------- ----- --------- ------ ----- --- --- --------- --------- ------ ----- ----- ----- ----- ----- ----- ----- ---- ---------------------
Rer1                 PF03248.12   171 AT2G18240.1          -            221   2.3e-61  206.4  10.4   1   2   4.3e-65   7.1e-61  204.8  11.2     4   168    24   181    21   183 0.96 Rer1 family
Rer1                 PF03248.12   171 AT2G18240.1          -            221   2.3e-61  206.4  10.4   2   2      0.43   7.2e+03   -3.6   0.0    55    67   187   199   184   217 0.69 Rer1 family
DUF4220              PF13968.5    352 AT5G45530.1          -            798   4.6e-78  263.0   0.0   1   1   1.5e-81   1.3e-77  261.5   0.0     1   344    51   396    51   427 0.78 Domain of unknown function (DUF4220)
DUF594               PF04578.12    55 AT5G45530.1          -            798   4.7e-24   83.6   1.5   1   1   1.3e-27   1.1e-23   82.4   1.5     3    55   726   778   724   778 0.96 Protein of unknown function, DUF594
DEAD                 PF00270.28   176 AT1G27880.2          -            890   6.7e-20   71.5   0.1   1   1   3.4e-23   1.9e-19   70.0   0.1     2   171   272   433   271   438 0.83 DEAD/DEAH box helicase
...
#
# Program:         hmmscan
# Version:         3.1b2 (February 2015)
# Pipeline mode:   SCAN
# Query file:      five.faa
# Target file:     /home/z/db/Pfam-A.hmm
# Option settings: hmmscan --tblout x.tblout --domtblout x.domtblout --pfamtblout x.pfamtblout --noali /home/z/db/Pfam-A.hmm five.faa 
# Current dir:     /home/z/src/git/rhmmer/tests/testthat/sample-data
# Date:            Fri Dec 15 02:09:00 2017
# [ok]
```

This is tricky to parse. It is mostly space delimited, but spaces appear freely
in the `description of target` column. The column names, as given, cannot be
directly used since they 1) contain illegal characters and 2) are not unique
unless information from two rows is considered (e.g. `ali_from` versus
`env_from`). The metadata at the end of the file I do not currently extract,
though I will likely add handling for this in the future.


```r
library(rhmmer)
domtblout <- system.file('extdata', 'example.domtblout.txt', package='rhmmer')
read_domtblout(domtblout)
```

```
## # A tibble: 70 x 23
##    domain_name domain_accession domain_len query_name query_accession  qlen
##    <chr>       <chr>                 <int> <chr>      <chr>           <int>
##  1 Rer1        PF03248.12              171 AT2G18240… -                 221
##  2 Rer1        PF03248.12              171 AT2G18240… -                 221
##  3 DUF4220     PF13968.5               352 AT5G45530… -                 798
##  4 DUF594      PF04578.12               55 AT5G45530… -                 798
##  5 DEAD        PF00270.28              176 AT1G27880… -                 890
##  6 Helicase_C  PF00271.30              111 AT1G27880… -                 890
##  7 Helicase_C  PF00271.30              111 AT1G27880… -                 890
##  8 ResIII      PF04851.14              171 AT1G27880… -                 890
##  9 ResIII      PF04851.14              171 AT1G27880… -                 890
## 10 TIR         PF01582.19              176 AT1G56520… -                 897
## 11 NB-ARC      PF00931.21              288 AT1G56520… -                 897
## 12 LRR_3       PF07725.11               20 AT1G56520… -                 897
## 13 LRR_3       PF07725.11               20 AT1G56520… -                 897
## 14 LRR_8       PF13855.5                61 AT1G56520… -                 897
## 15 LRR_8       PF13855.5                61 AT1G56520… -                 897
## 16 LRR_8       PF13855.5                61 AT1G56520… -                 897
## 17 LRR_8       PF13855.5                61 AT1G56520… -                 897
## 18 LRR_8       PF13855.5                61 AT1G56520… -                 897
## 19 LRR_8       PF13855.5                61 AT1G56520… -                 897
## 20 LRR_4       PF12799.6                43 AT1G56520… -                 897
## 21 LRR_4       PF12799.6                43 AT1G56520… -                 897
## 22 LRR_4       PF12799.6                43 AT1G56520… -                 897
## 23 LRR_4       PF12799.6                43 AT1G56520… -                 897
## 24 LRR_4       PF12799.6                43 AT1G56520… -                 897
## 25 TIR_2       PF13676.5               102 AT1G56520… -                 897
## 26 TIR_2       PF13676.5               102 AT1G56520… -                 897
## 27 AAA_16      PF13191.5               170 AT1G56520… -                 897
## 28 AAA_18      PF13238.5               130 AT1G56520… -                 897
## 29 AAA_22      PF13401.5               137 AT1G56520… -                 897
## 30 ATPase_2    PF01637.17              233 AT1G56520… -                 897
## 31 PhoH        PF02562.15              205 AT1G56520… -                 897
## 32 PhoH        PF02562.15              205 AT1G56520… -                 897
## 33 NACHT       PF05729.11              166 AT1G56520… -                 897
## 34 AAA_23      PF13476.5               200 AT1G56520… -                 897
## 35 AAA_23      PF13476.5               200 AT1G56520… -                 897
## 36 ABC_tran    PF00005.26              137 AT1G56520… -                 897
## 37 NTPase_1    PF03266.14              168 AT1G56520… -                 897
## 38 AAA_29      PF13555.5                61 AT1G56520… -                 897
## 39 AAA_29      PF13555.5                61 AT1G56520… -                 897
## 40 LRR_1       PF00560.32               23 AT1G56520… -                 897
## 41 LRR_1       PF00560.32               23 AT1G56520… -                 897
## 42 LRR_1       PF00560.32               23 AT1G56520… -                 897
## 43 LRR_1       PF00560.32               23 AT1G56520… -                 897
## 44 LRR_1       PF00560.32               23 AT1G56520… -                 897
## 45 LRR_1       PF00560.32               23 AT1G56520… -                 897
## 46 LRR_1       PF00560.32               23 AT1G56520… -                 897
## 47 LRR_1       PF00560.32               23 AT1G56520… -                 897
## 48 DAO         PF01266.23              352 AT3G10370… -                 629
## 49 DAO         PF01266.23              352 AT3G10370… -                 629
## 50 DAO_C       PF16901.4               126 AT3G10370… -                 629
## 51 FAD_bindin… PF00890.23              417 AT3G10370… -                 629
## 52 FAD_bindin… PF00890.23              417 AT3G10370… -                 629
## 53 FAD_oxidor… PF12831.6               433 AT3G10370… -                 629
## 54 FAD_oxidor… PF12831.6               433 AT3G10370… -                 629
## 55 Pyr_redox_2 PF07992.13              292 AT3G10370… -                 629
## 56 FAD_bindin… PF01494.18              356 AT3G10370… -                 629
## 57 FAD_bindin… PF01494.18              356 AT3G10370… -                 629
## 58 GIDA        PF01134.21              392 AT3G10370… -                 629
## 59 GIDA        PF01134.21              392 AT3G10370… -                 629
## 60 Pyr_redox   PF00070.26               81 AT3G10370… -                 629
## 61 HI0933_like PF03486.13              409 AT3G10370… -                 629
## 62 AAA_30      PF13604.5               192 AT3G10370… -                 629
## 63 AAA_30      PF13604.5               192 AT3G10370… -                 629
## 64 Pyr_redox_3 PF13738.5               305 AT3G10370… -                 629
## 65 DUF4179     PF13786.5                88 AT3G10370… -                 629
## 66 DUF4179     PF13786.5                88 AT3G10370… -                 629
## 67 3HCDH_N     PF02737.17              180 AT3G10370… -                 629
## 68 3HCDH_N     PF02737.17              180 AT3G10370… -                 629
## 69 NAD_bindin… PF13450.5                68 AT3G10370… -                 629
## 70 NAD_bindin… PF13450.5                68 AT3G10370… -                 629
##    sequence_evalue sequence_score sequence_bias domain_N domain_of
##              <dbl>          <dbl>         <dbl>    <int>     <int>
##  1        2.30e-61          206.           10.4        1         2
##  2        2.30e-61          206.           10.4        2         2
##  3        4.60e-78          263             0          1         1
##  4        4.70e-24           83.6           1.5        1         1
##  5        6.70e-20           71.5           0.1        1         1
##  6        3.20e-18           66             0          1         2
##  7        3.20e-18           66             0          2         2
##  8        1.20e- 3           18.8           0.1        1         2
##  9        1.20e- 3           18.8           0.1        2         2
## 10        7.30e-46          156.            0          1         1
## 11        1.90e-17           63.1           0          1         1
## 12        1.00e- 7           31.4           1.1        1         2
## 13        1.00e- 7           31.4           1.1        2         2
## 14        2.30e- 7           30.4           7          1         6
## 15        2.30e- 7           30.4           7          2         6
## 16        2.30e- 7           30.4           7          3         6
## 17        2.30e- 7           30.4           7          4         6
## 18        2.30e- 7           30.4           7          5         6
## 19        2.30e- 7           30.4           7          6         6
## 20        2.70e- 7           30.6          17.6        1         5
## 21        2.70e- 7           30.6          17.6        2         5
## 22        2.70e- 7           30.6          17.6        3         5
## 23        2.70e- 7           30.6          17.6        4         5
## 24        2.70e- 7           30.6          17.6        5         5
## 25        2.60e- 5           24.4           0.1        1         2
## 26        2.60e- 5           24.4           0.1        2         2
## 27        2.00e- 4           21.7           0.3        1         1
## 28        1.00e- 3           19.5           0          1         1
## 29        4.80e- 3           17.1           1          1         1
## 30        1.50e- 2           15.1           0          1         1
## 31        2.80e- 2           13.8           1.1        1         2
## 32        2.80e- 2           13.8           1.1        2         2
## 33        2.90e- 2           14.2           0          1         1
## 34        3.90e- 2           14.4           0          1         2
## 35        3.90e- 2           14.4           0          2         2
## 36        4.40e- 2           14.2           0          1         1
## 37        6.20e- 2           13.1           0          1         1
## 38        7.90e- 2           12.6           0.1        1         2
## 39        7.90e- 2           12.6           0.1        2         2
## 40        1.50e- 1           12.6          14.8        1         8
## 41        1.50e- 1           12.6          14.8        2         8
## 42        1.50e- 1           12.6          14.8        3         8
## 43        1.50e- 1           12.6          14.8        4         8
## 44        1.50e- 1           12.6          14.8        5         8
## 45        1.50e- 1           12.6          14.8        6         8
## 46        1.50e- 1           12.6          14.8        7         8
## 47        1.50e- 1           12.6          14.8        8         8
## 48        3.20e-53          181.            0.1        1         2
## 49        3.20e-53          181.            0.1        2         2
## 50        9.00e-39          132.            0.3        1         1
## 51        6.30e- 7           28.7           1.9        1         2
## 52        6.30e- 7           28.7           1.9        2         2
## 53        1.00e- 4           21.7           1.1        1         2
## 54        1.00e- 4           21.7           1.1        2         2
## 55        1.40e- 2           14.6           0          1         1
## 56        1.50e- 2           14.5           0.2        1         2
## 57        1.50e- 2           14.5           0.2        2         2
## 58        3.60e- 2           13             0.2        1         2
## 59        3.60e- 2           13             0.2        2         2
## 60        6.30e- 2           13.8           0.7        1         1
## 61        7.50e- 2           11.6           0.2        1         1
## 62        7.70e- 2           12.6           0.6        1         2
## 63        7.70e- 2           12.6           0.6        2         2
## 64        1.00e- 1           11.7           0          1         1
## 65        1.80e- 1           12.2           0.9        1         2
## 66        1.80e- 1           12.2           0.9        2         2
## 67        3.10e- 1           10.8           2          1         2
## 68        3.10e- 1           10.8           2          2         2
## 69        1.40e+ 0            9.1           5          1         2
## 70        1.40e+ 0            9.1           5          2         2
##    domain_cevalue domain_ievalue domain_score domain_bias hmm_from hmm_to
##             <dbl>          <dbl>        <dbl>       <dbl>    <int>  <int>
##  1       4.30e-65       7.10e-61        205.         11.2        4    168
##  2       4.30e- 1       7.20e+ 3         -3.6         0         55     67
##  3       1.50e-81       1.30e-77        262.          0          1    344
##  4       1.30e-27       1.10e-23         82.4         1.5        3     55
##  5       3.40e-23       1.90e-19         70           0.1        2    171
##  6       3.10e- 1       1.70e+ 3         -0.7         0         21     72
##  7       5.40e-21       3.00e-17         62.9         0         15    110
##  8       1.70e+ 0       9.40e+ 3         -3.7         0.1      102    123
##  9       1.50e- 6       8.40e- 3         16           0          4    169
## 10       1.30e-48       1.20e-45        155.          0          2    164
## 11       3.60e-20       3.50e-17         62.3         0          4    262
## 12       1.00e-10       1.00e- 7         31.4         1.1        1     20
## 13       1.30e+ 0       1.30e+ 3         -0.6         0.5        1     14
## 14       1.10e+ 0       1.10e+ 3         -0.6         0         15     31
## 15       1.30e- 3       1.30e+ 0          8.8         0.3        2     58
## 16       6.40e- 3       6.20e+ 0          6.6         0.2        2     59
## 17       1.10e- 1       1.10e+ 2          2.6         0.1        2     57
## 18       4.90e- 6       4.80e- 3         16.5         0          2     60
## 19       2.00e- 3       2.00e+ 0          8.2         0.1       27     59
## 20       8.40e+ 0       8.30e+ 3         -2.6         0         19     33
## 21       6.60e- 3       6.50e+ 0          7.2         0.1        2     33
## 22       1.00e- 2       1.00e+ 1          6.6         0.3       12     38
## 23       1.70e- 3       1.60e+ 0          9.1         0          1     39
## 24       4.80e- 6       4.70e- 3         17.2         0.2        3     42
## 25       9.50e- 8       9.30e- 5         22.6         0          1     85
## 26       6.10e+ 0       6.00e+ 3         -2.5         0.1       16     55
## 27       7.80e- 7       7.70e- 4         19.8         0.3        3     63
## 28       2.40e- 6       2.40e- 3         18.3         0          1     69
## 29       2.40e- 5       2.40e- 2         14.8         1          7    113
## 30       4.70e- 5       4.60e- 2         13.5         0          8     82
## 31       3.60e- 3       3.50e+ 0          6.9         0.2       18     39
## 32       1.10e- 2       1.10e+ 1          5.3         0         87    161
## 33       5.80e- 5       5.70e- 2         13.2         0          3     95
## 34       3.50e- 4       3.40e- 1         11.3         0         20     50
## 35       1.40e+ 0       1.40e+ 3         -0.5         0        118    143
## 36       9.60e- 5       9.50e- 2         13.1         0         12     36
## 37       1.60e- 4       1.60e- 1         11.8         0          2     87
## 38       1.30e- 3       1.30e+ 0          8.7         0.1       18     42
## 39       3.60e- 1       3.50e+ 2          0.9         0          3     25
## 40       8.60e+ 0       8.50e+ 3         -1.9         0          1     13
## 41       1.90e+ 0       1.90e+ 3          0.1         0.1        1     12
## 42       7.10e- 1       7.00e+ 2          1.4         0          1     21
## 43       1.90e- 1       1.90e+ 2          3.1         0          1     13
## 44       6.40e+ 0       6.20e+ 3         -1.5         0          3     13
## 45       2.40e- 2       2.40e+ 1          5.9         0          2     12
## 46       1.70e- 1       1.60e+ 2          3.3         0.3        1     16
## 47       4.40e+ 0       4.30e+ 3         -1           0          8     21
## 48       7.20e-56       8.60e-53        180.          0          1    351
## 49       1.40e+ 0       1.70e+ 3         -1.8         0.1       68    106
## 50       1.30e-41       1.60e-38        131.          0.3        1    125
## 51       1.90e- 6       2.30e- 3         17           1.2        1     41
## 52       2.40e- 4       2.90e- 1         10.1         0        154    213
## 53       3.60e- 7       4.30e- 4         19.7         0.3        1     40
## 54       3.40e- 1       4.10e+ 2         -0.1         0        100    143
## 55       2.60e- 5       3.10e- 2         13.4         0          2     36
## 56       3.30e- 4       3.90e- 1          9.8         0.5        3     51
## 57       6.90e- 2       8.30e+ 1          2.2         0        117    179
## 58       1.90e- 4       2.30e- 1         10.4         0.1        1     29
## 59       2.70e- 1       3.30e+ 2          0           0        110    159
## 60       2.30e- 4       2.80e- 1         11.7         0.7        2     32
## 61       1.20e- 4       1.50e- 1         10.6         0.2        2     32
## 62       3.10e+ 0       3.70e+ 3         -2.7         0.1        5     39
## 63       1.40e- 4       1.70e- 1         11.5         0         32     81
## 64       1.50e- 4       1.80e- 1         10.9         0        166    220
## 65       5.90e- 4       7.10e- 1         10.3         0          5     37
## 66       1.50e+ 0       1.80e+ 3         -0.6         0.1       10     57
## 67       3.00e- 4       3.60e- 1         10.6         0.2        2     32
## 68       1.90e+ 0       2.20e+ 3         -1.8         0.1       30     65
## 69       2.70e- 4       3.20e- 1         11.2         0.6        1     42
## 70       4.60e+ 0       5.50e+ 3         -2.4         0         31     40
## # ... with 6 more variables: ali_from <int>, ali_to <int>, env_from <int>,
## #   env_to <int>, acc <dbl>, description <chr>
```

The `tblout` output is fairly similar and presents the same parsing difficulties:

```
#                                                               --- full sequence ---- --- best 1 domain ---- --- domain number estimation ----
# target name        accession  query name           accession    E-value  score  bias   E-value  score  bias   exp reg clu  ov env dom rep inc description of target
#------------------- ---------- -------------------- ---------- --------- ------ ----- --------- ------ -----   --- --- --- --- --- --- --- --- ---------------------
Rer1                 PF03248.12 AT2G18240.1          -            2.3e-61  206.4  10.4   7.1e-61  204.8  11.2   1.3   2   0   0   2   2   2   1 Rer1 family
DUF4220              PF13968.5  AT5G45530.1          -            4.6e-78  263.0   0.0   1.3e-77  261.5   0.0   1.7   1   1   0   1   1   1   1 Domain of unknown function (DUF4220)
DUF594               PF04578.12 AT5G45530.1          -            4.7e-24   83.6   1.5   1.1e-23   82.4   1.5   1.7   1   0   0   1   1   1   1 Protein of unknown function, DUF594
DEAD                 PF00270.28 AT1G27880.2          -            6.7e-20   71.5   0.1   1.9e-19   70.0   0.1   1.8   1   0   0   1   1   1   1 DEAD/DEAH box helicase
Helicase_C           PF00271.30 AT1G27880.2          -            3.2e-18   66.0   0.0     3e-17   62.9   0.0   2.5   2   0   0   2   2   2   1 Helicase conserved C-terminal domain
ResIII               PF04851.14 AT1G27880.2          -             0.0012   18.8   0.1    0.0084   16.0   0.0   2.4   2   1   0   2   2   2   1 Type III restriction enzyme, res subunit
...
#
# Program:         hmmscan
# Version:         3.1b2 (February 2015)
# Pipeline mode:   SCAN
# Query file:      five.faa
# Target file:     /home/z/db/Pfam-A.hmm
# Option settings: hmmscan --tblout x.tblout --domtblout x.domtblout --pfamtblout x.pfamtblout --noali /home/z/db/Pfam-A.hmm five.faa 
# Current dir:     /home/z/src/git/rhmmer/tests/testthat/sample-data
# Date:            Fri Dec 15 02:09:00 2017
# [ok]
```


```r
tblout <- system.file('extdata', 'example.tblout.txt', package='rhmmer')
read_tblout(tblout)
```

```
## # A tibble: 37 x 19
##    domain_name domain_accession query_name query_accession sequence_evalue
##    <chr>       <chr>            <chr>      <chr>                     <dbl>
##  1 Rer1        PF03248.12       AT2G18240… -                      2.30e-61
##  2 DUF4220     PF13968.5        AT5G45530… -                      4.60e-78
##  3 DUF594      PF04578.12       AT5G45530… -                      4.70e-24
##  4 DEAD        PF00270.28       AT1G27880… -                      6.70e-20
##  5 Helicase_C  PF00271.30       AT1G27880… -                      3.20e-18
##  6 ResIII      PF04851.14       AT1G27880… -                      1.20e- 3
##  7 TIR         PF01582.19       AT1G56520… -                      7.30e-46
##  8 NB-ARC      PF00931.21       AT1G56520… -                      1.90e-17
##  9 LRR_3       PF07725.11       AT1G56520… -                      1.00e- 7
## 10 LRR_8       PF13855.5        AT1G56520… -                      2.30e- 7
## 11 LRR_4       PF12799.6        AT1G56520… -                      2.70e- 7
## 12 TIR_2       PF13676.5        AT1G56520… -                      2.60e- 5
## 13 AAA_16      PF13191.5        AT1G56520… -                      2.00e- 4
## 14 AAA_18      PF13238.5        AT1G56520… -                      1.00e- 3
## 15 AAA_22      PF13401.5        AT1G56520… -                      4.80e- 3
## 16 ATPase_2    PF01637.17       AT1G56520… -                      1.50e- 2
## 17 PhoH        PF02562.15       AT1G56520… -                      2.80e- 2
## 18 NACHT       PF05729.11       AT1G56520… -                      2.90e- 2
## 19 AAA_23      PF13476.5        AT1G56520… -                      3.90e- 2
## 20 ABC_tran    PF00005.26       AT1G56520… -                      4.40e- 2
## 21 NTPase_1    PF03266.14       AT1G56520… -                      6.20e- 2
## 22 AAA_29      PF13555.5        AT1G56520… -                      7.90e- 2
## 23 LRR_1       PF00560.32       AT1G56520… -                      1.50e- 1
## 24 DAO         PF01266.23       AT3G10370… -                      3.20e-53
## 25 DAO_C       PF16901.4        AT3G10370… -                      9.00e-39
## 26 FAD_bindin… PF00890.23       AT3G10370… -                      6.30e- 7
## 27 FAD_oxidor… PF12831.6        AT3G10370… -                      1.00e- 4
## 28 Pyr_redox_2 PF07992.13       AT3G10370… -                      1.40e- 2
## 29 FAD_bindin… PF01494.18       AT3G10370… -                      1.50e- 2
## 30 GIDA        PF01134.21       AT3G10370… -                      3.60e- 2
## 31 Pyr_redox   PF00070.26       AT3G10370… -                      6.30e- 2
## 32 HI0933_like PF03486.13       AT3G10370… -                      7.50e- 2
## 33 AAA_30      PF13604.5        AT3G10370… -                      7.70e- 2
## 34 Pyr_redox_3 PF13738.5        AT3G10370… -                      1.00e- 1
## 35 DUF4179     PF13786.5        AT3G10370… -                      1.80e- 1
## 36 3HCDH_N     PF02737.17       AT3G10370… -                      3.10e- 1
## 37 NAD_bindin… PF13450.5        AT3G10370… -                      1.40e+ 0
##    sequence_score sequence_bias best_domain_eva… best_domain_sco…
##             <dbl>         <dbl>            <dbl>            <dbl>
##  1          206.           10.4         7.10e-61            205. 
##  2          263             0           1.30e-77            262. 
##  3           83.6           1.5         1.10e-23             82.4
##  4           71.5           0.1         1.90e-19             70  
##  5           66             0           3.00e-17             62.9
##  6           18.8           0.1         8.40e- 3             16  
##  7          156.            0           1.20e-45            155. 
##  8           63.1           0           3.50e-17             62.3
##  9           31.4           1.1         1.00e- 7             31.4
## 10           30.4           7           4.80e- 3             16.5
## 11           30.6          17.6         4.70e- 3             17.2
## 12           24.4           0.1         9.30e- 5             22.6
## 13           21.7           0.3         7.70e- 4             19.8
## 14           19.5           0           2.40e- 3             18.3
## 15           17.1           1           2.40e- 2             14.8
## 16           15.1           0           4.60e- 2             13.5
## 17           13.8           1.1         3.50e+ 0              6.9
## 18           14.2           0           5.70e- 2             13.2
## 19           14.4           0           3.40e- 1             11.3
## 20           14.2           0           9.50e- 2             13.1
## 21           13.1           0           1.60e- 1             11.8
## 22           12.6           0.1         1.30e+ 0              8.7
## 23           12.6          14.8         2.40e+ 1              5.9
## 24          181.            0.1         8.60e-53            180. 
## 25          132.            0.3         1.60e-38            131. 
## 26           28.7           1.9         2.30e- 3             17  
## 27           21.7           1.1         4.30e- 4             19.7
## 28           14.6           0           3.10e- 2             13.4
## 29           14.5           0.2         3.90e- 1              9.8
## 30           13             0.2         2.30e- 1             10.4
## 31           13.8           0.7         2.80e- 1             11.7
## 32           11.6           0.2         1.50e- 1             10.6
## 33           12.6           0.6         1.70e- 1             11.5
## 34           11.7           0           1.80e- 1             10.9
## 35           12.2           0.9         7.10e- 1             10.3
## 36           10.8           2           3.60e- 1             10.6
## 37            9.1           5           3.20e- 1             11.2
##    best_domain_bis domain_number_e… domain_number_r… domain_number_c…
##              <dbl>            <dbl>            <int>            <int>
##  1            11.2              1.3                2                0
##  2             0                1.7                1                1
##  3             1.5              1.7                1                0
##  4             0.1              1.8                1                0
##  5             0                2.5                2                0
##  6             0                2.4                2                1
##  7             0                1.4                1                0
##  8             0                1.4                1                0
##  9             1.1              2.7                2                0
## 10             0                5.5                3                2
## 11             0.2              6.1                6                1
## 12             0                1.9                2                0
## 13             0.3              2                  1                1
## 14             0                1.7                1                0
## 15             1                2.1                1                1
## 16             0                1.8                1                1
## 17             0.2              2.3                1                1
## 18             0                1.5                1                0
## 19             0                2.3                2                0
## 20             0                1.5                1                0
## 21             0                1.7                1                1
## 22             0.1              2.3                2                0
## 23             0                7.8                8                1
## 24             0                1.6                2                0
## 25             0.3              1.4                1                0
## 26             1.2              2.3                2                0
## 27             0.3              2.2                2                0
## 28             0                1.5                1                0
## 29             0.5              2.1                2                0
## 30             0.1              2                  2                0
## 31             0.7              2.1                1                0
## 32             0.2              1.5                1                0
## 33             0                1.9                2                0
## 34             0                1.3                1                0
## 35             0                2.2                2                0
## 36             0.2              2                  2                0
## 37             0.6              2.3                3                0
## # ... with 6 more variables: domain_number_ov <int>,
## #   domain_number_env <int>, domain_number_dom <int>,
## #   domain_number_rep <int>, domain_number_inc <chr>, description <chr>
```


## What `rhmmer` does and doesn't

What `rhmmer` currently does

 * parse HMMER output (tblout and domtblout) into tidy data frames

What `rhmmer` may do in the future

 * provide visualization or analysis of HMMER results 

 * provide simple wrappers for calling some of the HMMER functions

 * parse metadata from the comments in HMMER output files

 * read pfamtblout and the raw output (with alignments)

 * read the HMM models

 * download databases for you (e.g. PFAM)

 * access precompiled PFAM results

What `rhmmer` will never do

 * interface with the HMMER web server (use Bio3D)

 * duplicate the whole HMMER api (just use the CLI tool)


## TODO

 [ ] Rewrite the parser in C++

 [ ] Parse out the file metadata
