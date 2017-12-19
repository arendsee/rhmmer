#' @importFrom magrittr "%>%"
#' @importFrom rlang .data
#' @importFrom utils head
utils::globalVariables(c("%>%", "."))
NULL

#' rhmmer: utilities for 'HMMER'
#'
#' Currently rhmmer exports exactly two functions:
#'
#' \describe{
#'    \item{\code{read_tblout}}{Read a file made by HMMER '----tblout'}
#'    \item{\code{read_domtblout}}{Read a file made by HMMER '----domtblout'}
#' }
#'
#' @docType package
#' @name rhmmer 
NULL
