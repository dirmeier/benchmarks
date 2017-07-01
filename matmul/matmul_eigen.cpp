#include <iostream>
#include <Eigen/Dense>

int main()
{
    const unsigned int m = 2500;
    Eigen::MatrixXd mat = Eigen::MatrixXd::Constant(m, m, 0.001);
    Eigen::MatrixXd mk = mat * mat;
    std::cout << mk.sum() << std::endl;
    return 0;
}
