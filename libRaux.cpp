#include "libRaux.h"

/* The following two functions are necessary because Cython does not support operator= yet. */

void libRaux::setBinding(RInside *rinside, const string key, SEXP arg) {
    (*rinside)[key] = arg;
}

void libRaux::setBinding(RInside *rinside, const string key, const Rcpp::Environment::Binding &arg) {
    (*rinside)[key] = arg;
}
