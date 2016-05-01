fn_remove_files_from_output_dir <- function() {
  # Peer review: Ilkka Havukkala 21 April 2016 OK
  path_output <- file.path(PROJHOME, "outputs")
  # get a vector of all files in outputs/*
  vct_files <- list.files(path_output, full.names = TRUE, recursive = TRUE)
  # get a matrix of file paths that match with the search string
  mat_matched_files <- str_match(vct_files, "export_intelligence/outputs/consolidated_pdf/")
  # filter the vector of files based on the matrix in the previous line
  vct_relevant_files <- vct_files[is.na(mat_matched_files[,1])]
  # now cast the vector to a list so we can put it into do.call()
  lst_files <- list(vct_relevant_files)
  # suppress output from do.call()
  invisible(
    do.call(file.remove, lst_files) )
}