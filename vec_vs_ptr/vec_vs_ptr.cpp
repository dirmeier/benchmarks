#include <vector>
#include <iostream>
#include <chrono>


void fill_ptr(int* ptr, const size_t size)
{
	for (size_t i = 0; i < size; ++i)
	{
		ptr[i] = i;
	}
}

void fill_vec(std::vector<int>& ptr, const size_t size)
{
	for (size_t i = 0; i < size; ++i)
	{
		ptr[i] = i;
	}
}

void benchmark(const size_t sz)
{	
	std::chrono::steady_clock::time_point begin;
	std::chrono::steady_clock::time_point end;

	int* ptr = new int[sz];
	std::vector<int> vec(sz);

	begin = std::chrono::steady_clock::now();
	fill_ptr(ptr, sz);	
	end = std::chrono::steady_clock::now();
	std::cout << sz << "\tptr w/o alloc\t" << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() <<std::endl;
	delete [] ptr;
	
	begin = std::chrono::steady_clock::now();
	fill_vec(vec, sz);	
	end = std::chrono::steady_clock::now();
	std::cout << sz << "\tvec w/o alloc\t" << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() <<std::endl;

	begin = std::chrono::steady_clock::now();
	ptr = new int[sz];
	fill_ptr(ptr, sz);	
	end = std::chrono::steady_clock::now();
	std::cout << sz << "\tptr with alloc\t" << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() <<std::endl;
	delete [] ptr;

	begin = std::chrono::steady_clock::now();
	std::vector<int> vec2(sz);
	fill_vec(vec2, sz);	
	end = std::chrono::steady_clock::now();
	std::cout << sz << "\tvec with alloc\t" << std::chrono::duration_cast<std::chrono::microseconds>(end - begin).count() <<std::endl;	
}

int main()
{

	std::vector<size_t> B{100, 1000, 10000, 100000};
	for (auto b: B) {
		for (int i = 0; i < 10; ++i) {
			benchmark(b);			
		}
	}
	return 0;
}