#include <Rcpp.h>
#include <RInside.h>
#include <string>

using namespace std;

namespace libRaux {
    void setBinding(RInside *rinside, const string key, SEXP arg);
    void setBinding(RInside *rinside, const string key, const Rcpp::Environment::Binding &arg);
}
