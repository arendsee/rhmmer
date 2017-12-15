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
  column_names <- if(type == 'tblout'){
    c(
      'domain_name',
      'domain_accession',
      'query_name',
      'query_accession',
      'sequence_evalue',
      'sequence_score',
      'sequence_bias',
      'best_domain_evalue',
      'best_domain_score',
      'best_domain_bis',
      'domain_number_exp',
      'domain_number_reg',
      'domain_number_clu',
      'domain_number_ov',
      'domain_number_env',
      'domain_number_dom',
      'domain_number_rep',
      'domain_number_inc',
      'description'
    )
  } else if(type == 'domtblout') {
    c(
      'domain_name',
      'domain_accession',
      'domain_len',
      'query_name',
      'query_accession',
      'qlen',
      'sequence_evalue',
      'sequence_score',
      'sequence_bias',
      'domain_N',
      'domain_of',
      'domain_cevalue',
      'domain_ievalue',
      'domain_score',
      'domain_bias',
      'hmm_from',
      'hmm_to',
      'ali_from',
      'ali_to',
      'env_from',
      'env_to',
      'acc',
      'description'
    )
  }

  N <- length(column_names)

  readr::read_lines(file) %>%
    Filter(f=function(x) grepl('^[^#]', x)) %>%
    sub(
      pattern = sprintf("(%s) *(.*)", paste0(rep('\\S+', N-1), collapse=" +")),
      replacement = '\\1\t\\2',
      perl = TRUE
    ) %>%
    paste0(collapse="\n") %>%
    readr::read_tsv(col_names=c('X', 'description')) %>%
    tidyr::separate(.data$X, head(column_names, -1), sep=' +')
}
