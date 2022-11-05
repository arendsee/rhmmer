#' Read and format a HMMprofile file from HMMbuild into tabular format
#'
#' @param file Filename
#' @return data.frame
#' @export
#' @examples
#' file <- system.file('extdata', 'example.hmmprofile.hmm', package='rhmmer')
#' read_hmmprofile(file)
read_hmmprofile <- function(file){
  text = readLines(file)
  
  start = grep("HMM", text)[2]
  end = grep("//", text)
  
  if(length(start) == 0 || length(end) == 0) {stop("malformed hmm profile")}
  
  # parser currently only handles /f formatted .hmm files
  if( grepl("HMMER3/f", text[1]) ){
    text = text[start:end]
    
    
    which_emmission = grep(" [0-9]{1,9} ", text)
    which_transition = which_emmission + 2
    
    if(length(start) == 0 || length(end) == 0) {stop("the parser cannot find residue emmission or transition probabilities")}
    
    df_emmission = read.table(text = text[which_emmission])[,1:21]
    df_transition = read.table(text = text[which_transition])
    
    df = cbind(df_emmission,
               df_transition)
    
    colnames(df) = c("position",
                     "A",
                     "C",
                     "D",
                     "E",
                     "F",
                     "G",
                     "H",
                     "I",
                     "K",
                     "L",
                     "M",
                     "N",
                     "P",
                     "Q",
                     "R",
                     "S",
                     "T",
                     "V",
                     "W",
                     "Y",
                     "m->m",
                     "m->i",
                     "m->d",
                     "i->m",
                     "i->i",
                     "d->m",
                     "d->d")
  }
  
  return(df)
}
