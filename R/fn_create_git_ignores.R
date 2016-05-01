fn_create_git_ignores <- function() {

  # Peer review: Ilkka Havukkala 21 April 2016 OK, add explanation why this is needed
  
  
  nline <- paste0("\n")
  str_git_ig <-   paste0("# Ignore everything in this directory", nline,
                  "*", nline,
                  "# Except this file", nline,
                  "!.gitignore")
  
  str_git_file_name <- ".gitignore"
  
  
  git_path <- file.path(PROJHOME, "outputs", "compile_tex", str_git_file_name)
  writeLines(str_git_ig, git_path)
  
#  git_path <- file.path(PROJHOME, "outputs", "consolidated_pdf", str_git_file_name)
#  writeLines(str_git_ig, git_path)
  
  git_path <- file.path(PROJHOME, "outputs", "cover_page", str_git_file_name)
  writeLines(str_git_ig, git_path)
  
  git_path <- file.path(PROJHOME, "outputs", "graphs","monthly_number_countries",  str_git_file_name)
  writeLines(str_git_ig, git_path)
  
  git_path <- file.path(PROJHOME, "outputs", "graphs","monthly_value",  str_git_file_name)
  writeLines(str_git_ig, git_path)
  
  git_path <- file.path(PROJHOME, "outputs", "graphs","monthly_volume",  str_git_file_name)
  writeLines(str_git_ig, git_path)
  
  git_path <- file.path(PROJHOME, "outputs", "graphs","smoothed_price",  str_git_file_name)
  writeLines(str_git_ig, git_path)
  
  git_path <- file.path(PROJHOME, "outputs", "graphs","yearly_summary",  str_git_file_name)
  writeLines(str_git_ig, git_path)
  
  git_path <- file.path(PROJHOME, "outputs", "latex_knitr", str_git_file_name)
  writeLines(str_git_ig, git_path)
  
  git_path <- file.path(PROJHOME, "outputs", "latex_table", str_git_file_name)
  writeLines(str_git_ig, git_path)
  
  git_path <- file.path(PROJHOME, "outputs", "latex_tex", str_git_file_name)
  writeLines(str_git_ig, git_path)
  
  git_path <- file.path(PROJHOME, "outputs", "pdf", str_git_file_name)
  writeLines(str_git_ig, git_path)

}
