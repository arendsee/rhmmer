#' Read a file created through the '-tblout' option
#'
#' @param file Filename
#' @return data.frame
#' @export
read_tblout <- function(file){
  .parse_hmmer_output(file, 'tblout')
}

#' Read a file created through the '-domtblout' option
#'
#' @param file Filename
#' @return data.frame
#' @export
read_domtblout <- function(file){
  .parse_hmmer_output(file, 'domtblout')
}


.parse_hmmer_output <- function(file, type){

  col_types <- if(type == 'tblout'){
    readr::cols(
      domain_name         = col_character(),
      domain_accession    = col_character(),
      query_name          = col_character(),
      query_accession     = col_character(),
      sequence_evalue     = col_double(),
      sequence_score      = col_double(),
      sequence_bias       = col_double(),
      best_domain_evalue  = col_double(),
      best_domain_score   = col_double(),
      best_domain_bis     = col_double(),
      domain_number_exp   = col_double(),
      domain_number_reg   = col_integer(),
      domain_number_clu   = col_integer(),
      domain_number_ov    = col_integer(),
      domain_number_env   = col_integer(),
      domain_number_dom   = col_integer(),
      domain_number_rep   = col_integer(),
      domain_number_inc   = col_character(),
      description         = col_character()
    )
  } else if(type == 'domtblout'){
    readr::cols(
      domain_name         = col_character(),
      domain_accession    = col_character(),
      domain_len          = col_integer(),
      query_name          = col_character(),
      query_accession     = col_character(),
      qlen                = col_integer(),
      sequence_evalue     = col_double(),
      sequence_score      = col_double(),
      sequence_bias       = col_double(),
      domain_N            = col_integer(),
      domain_of           = col_integer(),
      domain_cevalue      = col_double(),
      domain_ievalue      = col_double(),
      domain_score        = col_double(),
      domain_bias         = col_double(),
      hmm_from            = col_integer(),
      hmm_to              = col_integer(),
      ali_from            = col_integer(),
      ali_to              = col_integer(),
      env_from            = col_integer(),
      env_to              = col_integer(),
      acc                 = col_double(),
      description         = col_character()
    )
  }

  N <- length(col_types$cols)

  readr::read_lines(file) %>%
    Filter(f=function(x) grepl('^[^#]', x)) %>%
    sub(
      pattern = sprintf("(%s) *(.*)", paste0(rep('\\S+', N-1), collapse=" +")),
      replacement = '\\1\t\\2',
      perl = TRUE
    ) %>%
    paste0(collapse="\n") %>%
    readr::read_tsv(col_names=c('X', 'description')) %>%
    tidyr::separate(.data$X, head(names(col_types$cols), -1), sep=' +') %>%
    readr::type_convert(col_types=col_types)
}
