# this is a script to get include and linking paths
cat(c(Sys.getenv("R_INCLUDE_DIR"), "\n"))
cat(c(system.file(package="Rcpp"), "\n"))
cat(c(system.file(package="RInside"), "\n"))
