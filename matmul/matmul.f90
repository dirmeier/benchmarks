
      program gd
      double precision, dimension(:, :), allocatable :: m, n
      integer :: i = 2500
      allocate( n(i, i) )
      allocate( m(i, i) )
      m = 0.001
      n = MATMUL(m, m)
      print *, sum(n)
      deallocate(m, n)
      end
