Matrix multiplications
======================

Simple matrix multiplication benchmark for `Eigen3`, `Armadillo`, `FORTRAN`, `R` and `python`.

## Results

Amazingly `python/numpy` outperformed all of the other languages/libraries. Even when built against OpenBlas, python was fastest. Is this due to poor implementations of the other languages? You cannot do much with R, though.

<div align="center">
<img src="https://github.com/dirmeier/benchmarks/blob/master/matmul/data/time.png" alt="Drawing" width="75%" />
</div>

## Usage

For `Eigen3` usage (supposing you have an Eigen installation in `/opt/local/eigen3`):

```sh
  g++ -std=c++11 -O3 -I/opt/local/eigen3/ matmul_eigen.cpp -o eigen
  (time ./eigen) >> result.txt 2>> time.txt
```

For `Armadillo` usage (with armadillo installed in `/opt/local/armadillo`) on a mac without OpenBlas. Building with OpenBlas did not change much:

```sh
  g++ -std=c++11 -O3  -I/opt/local/armadillo/include -DARMA_DONT_USE_WRAPPER matmul_armadillo.cpp -o armadillo -framework Accelerate
  (time ./armadillo) >> result.txt 2>> time.txt
```

For `FORTRAN` usage:

```sh
  gfortran -O3 matmul.f90 -o fortran
  (time ./fortran) >> result.txt 2>> time.txt
```

For `R` usage:

```sh
  (time ./R) >> result.txt 2>> time.txt
```

For `python` usage:

```sh
  (time ./python) >> result.txt 2>> time.txt
```
