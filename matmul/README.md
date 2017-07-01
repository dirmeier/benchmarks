Matrix multiplications
=================

Not really a numerical recipe, but for benchmarking purposes of `Eigen3` vs `Armadillo` vs `FORTRAN`.

## Usage

For `Eigen3` usage (supposing you have an Eigen installation in `/opt/local/eigen3`):

```sh
  g++ -std=c++11 -O3 -I/opt/local/eigen3/ matmul_eigen.cpp -o eigen
  time ./eigen
```

For `Armadillo` usage (with armadillo installed in `/opt/local/armadillo`):

```sh
  g++ -std=c++11 -O3 -I/opt/local/ardmadillo/ matmul_armadillo.cpp -o armadillo
  time ./armadillo
```

For `FORTRAN` usage:

```sh
  gfortran -O3 matmul.f90 -o fortran
  time ./fortran
```
