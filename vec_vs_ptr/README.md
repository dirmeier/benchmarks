Vector vs pointer
======================

Simple benchmark of `C++` vector vs pointer speeds.)

## Results

Turns out that vectors are **just as fine** to use as pointers. While pointers are faster if we additionally add the time it requires to allocate the objects (i.e. `new int[sz]` vs calling `std::vector<int>(sz)`), vectors are actually faster if we don't. Source files have been compiled with `-std=c++11` and `-O2`.

I hope this settles this futile debate.

<div align="center">
<img src="https://github.com/dirmeier/benchmarks/blob/master/vec_vs_ptr/data/time.png" alt="Drawing" width="75%" />
</div>

## Usage

```bash 
  mkdir build && meson build && cd build && ninja && cd ..
  ./run.sh  
```

Then start an `R`-session and source the script. You need the Roboto font installed.
