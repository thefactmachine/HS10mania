fn_remove_files_from_output_dir <- function() {
  path_output <- file.path(PROJHOME, "outputs")
  lst_files <- list(list.files(path_output, full.names = TRUE, recursive = TRUE))
  # suppress output from do.call()
  invisible(
    do.call(file.remove, lst_files) )
}