#include <iostream>
#include <armadillo>

int main()
{
    const unsigned int m = 2500;
    arma::Mat<double> mat(m, m);
    mat.fill(0.001);
    arma::Mat<double> mk = mat * mat;
    std::cout << arma::accu(mk) << std::endl;
    return 0;
}
