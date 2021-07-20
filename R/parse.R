#' Read a file created through the '----tblout' option
#'
#' @param file Filename
#' @return data.frame
#' @export
#' @examples
#' file <- system.file('extdata', 'example.tblout.txt', package='rhmmer')
#' read_tblout(file)
read_tblout <- function(file){
  .parse_hmmer_output(file, 'tblout')
}

#' Read a file created through the '----domtblout' option
#'
#' @param file Filename
#' @return data.frame
#' @export
#' @examples
#' file <- system.file('extdata', 'example.domtblout.txt', package='rhmmer')
#' read_domtblout(file)
read_domtblout <- function(file){
  .parse_hmmer_output(file, 'domtblout')
}


.parse_hmmer_output <- function(file, type){

  col_types <- if(type == 'tblout'){
    readr::cols(
      domain_name         = readr::col_character(),
      domain_accession    = readr::col_character(),
      query_name          = readr::col_character(),
      query_accession     = readr::col_character(),
      sequence_evalue     = readr::col_double(),
      sequence_score      = readr::col_double(),
      sequence_bias       = readr::col_double(),
      best_domain_evalue  = readr::col_double(),
      best_domain_score   = readr::col_double(),
      best_domain_bis     = readr::col_double(),
      domain_number_exp   = readr::col_double(),
      domain_number_reg   = readr::col_integer(),
      domain_number_clu   = readr::col_integer(),
      domain_number_ov    = readr::col_integer(),
      domain_number_env   = readr::col_integer(),
      domain_number_dom   = readr::col_integer(),
      domain_number_rep   = readr::col_integer(),
      domain_number_inc   = readr::col_character()
    )
  } else if(type == 'domtblout'){
    readr::cols(
      domain_name         = readr::col_character(),
      domain_accession    = readr::col_character(),
      domain_len          = readr::col_integer(),
      query_name          = readr::col_character(),
      query_accession     = readr::col_character(),
      qlen                = readr::col_integer(),
      sequence_evalue     = readr::col_double(),
      sequence_score      = readr::col_double(),
      sequence_bias       = readr::col_double(),
      domain_N            = readr::col_integer(),
      domain_of           = readr::col_integer(),
      domain_cevalue      = readr::col_double(),
      domain_ievalue      = readr::col_double(),
      domain_score        = readr::col_double(),
      domain_bias         = readr::col_double(),
      hmm_from            = readr::col_integer(),
      hmm_to              = readr::col_integer(),
      ali_from            = readr::col_integer(),
      ali_to              = readr::col_integer(),
      env_from            = readr::col_integer(),
      env_to              = readr::col_integer(),
      acc                 = readr::col_double()
    )
  }

  N <- length(col_types$cols)

  lines <- readr::read_lines(file)

  table <- sub(
      pattern = sprintf("(%s).*", paste0(rep('\\S+', N), collapse=" +")),
      replacement = '\\1',
      x=lines,
      perl = TRUE
    ) %>%
    gsub(pattern="  *", replacement="\t") %>%
    paste0(collapse="\n") %>%
    readr::read_tsv(col_names=names(col_types$cols), comment='#', na='-', col_types = col_types)

  descriptions <- lines[!grepl("^#", lines, perl=TRUE)] %>%
    sub(
      pattern = sprintf("%s *(.*)", paste0(rep('\\S+', N), collapse=" +")),
      replacement = '\\1',
      perl = TRUE
    )

  table$description <- descriptions[!grepl(" *#", descriptions, perl=TRUE)]

  table
}
