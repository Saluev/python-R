#include "libRaux.h"

/* Some of the following functions are necessary because Cython does not support operator= yet. */

#define sB(a) \
    void libRaux::setBinding(RInside *rinside, const string key, a *arg) { \
        (*rinside)[key] = *arg; \
    }

sB(ComplexVector);
sB(IntegerVector);
sB(LogicalVector);
sB(NumericVector);
sB(StringVector);
sB(List);
sB(ExpressionVector);
sB(ComplexMatrix);
sB(IntegerMatrix);
sB(LogicalMatrix);
sB(NumericMatrix);
sB(StringMatrix);
sB(ListMatrix);
sB(ExpressionMatrix);

#define sgVv(a, b) \
    void libRaux::setValue(a *v, int i, b value) { \
        (*v)[i] = value; \
    } \
    b libRaux::getValue(a *v, int i) { \
        return (*v)[i]; \
    }
#define sgVm(a, b) \
    void libRaux::setValue(a *v, int i, int j, b value) { \
        (*v)(i, j) = value; \
    } \
    b libRaux::getValue(a *v, int i, int j) { \
        return (*v)(i, j); \
    }

sgVv(ComplexVector, Rcomplex);
sgVv(IntegerVector, long);
sgVv(LogicalVector, bool);
sgVv(NumericVector, double);
sgVv(StringVector, const char*);
// TODO: List, ExpressionVector
sgVm(ComplexMatrix, Rcomplex);
sgVm(IntegerMatrix, long);
sgVm(LogicalMatrix, bool);
sgVm(NumericMatrix, double);
sgVm(StringMatrix, const char*);
// TODO: ListMatrix, ExpressionMatrix




int main(int argc, char **argv) {
    //$ g++ build/temp.linux-i686-2.7/libRaux.o -o a.out /usr/local/lib/R/site-library/RInside/lib/libRInside.a /usr/lib/R/site-library/Rcpp/lib/libRcpp.a -L/usr/local/lib/R/lib/ -lR
    std::string evalstr = "";  // строка для формирования кода на R
    RInside R(argc, argv, true, true, false);  //окружение
    Rcpp::NumericVector RndVec(1000);  // создаем массив чисел
    for(int i = 0; i < 1000; ++i)
        RndVec(i) = (float)(rand() % 100); // заполняем его
    libRaux::setBinding(&R, "RndVec", &RndVec);
    //R["RndVec"] = RndVec; // связываем с массивом в R
    SEXP ans; // результат
    // формируем строку для R:
    // пробуем получить параметры распределения, считая, что это нормальный закон
    evalstr = "library(fitdistrplus) \n \
    out <- fitdist(RndVec, \"norm\", \'mme\')[[1]][[1]]; print(out); out";
    // получили результат
    ans = R.parseEval(evalstr);
    // получили матожидание 
    Rcpp::NumericVector mean(ans);
    std::cout << "mean " << " is " << mean[0] << std::endl;
    evalstr = "out <- fitdist(RndVec, \"norm\", \'mme\')[[1]][[2]]; print(out); out";
    ans = R.parseEval(evalstr);
    // получили ско
    Rcpp::NumericVector sd(ans);
    std::cout << "sd " << " is " << sd[0] << std::endl;
    R["curMean"] = mean[0];
    R["curSd"] = sd[0];
    // выполнили тест
    evalstr = "out <- ks.test(RndVec, \"pnorm\", curMean, curSd)[[2]]; print(out); out";
    ans = R.parseEval(evalstr);
    Rcpp::NumericVector v1(ans);
    // посчитали p.value
    std::cout << "p.value " << " is " << v1[0] << std::endl;
    return 0;
}

