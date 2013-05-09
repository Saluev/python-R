#include "libRaux.h"

/* Some of the following functions are necessary because Cython does not support operator= yet. */

void libRaux::setBinding(RInside *rinside, const string key, SEXP arg) {
    (*rinside)[key] = arg;
}

SEXP libRaux::getBinding(RInside *rinside, const string key) {
    return (*rinside)[key];
}


