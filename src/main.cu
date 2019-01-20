#include <iostream>
#include <cutf/memory.hpp>

namespace{
constexpr std::size_t N = 1 << 11;
using cuda_clock_t = unsigned long long;
__global__ void kernel(cuda_clock_t* start_clock, cuda_clock_t* end_clock){
	const auto tid = blockIdx.x;
	if(tid >= N)return;

	start_clock[tid] = clock64();
	end_clock[tid] = clock64();
}
}
int main(){
	auto d_start_clock = cutf::cuda::memory::get_device_unique_ptr<cuda_clock_t>(N);
	auto d_end_clock = cutf::cuda::memory::get_device_unique_ptr<cuda_clock_t>(N);
	auto h_start_clock = cutf::cuda::memory::get_host_unique_ptr<cuda_clock_t>(N);
	auto h_end_clock = cutf::cuda::memory::get_host_unique_ptr<cuda_clock_t>(N);

	kernel<<<N, 1>>>(d_start_clock.get(), d_end_clock.get());

	cutf::cuda::memory::copy(h_start_clock.get(), d_start_clock.get(), N);
	cutf::cuda::memory::copy(h_end_clock.get(), d_end_clock.get(), N);

	std::cout<<"tid,start,end"<<std::endl;
	for(std::size_t i = 0; i < N; i++){
		std::cout<<i<<","<<h_start_clock.get()[i]<<","<<h_end_clock.get()[i]<<std::endl;
	}
}
