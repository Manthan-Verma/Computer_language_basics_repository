
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <cuda.h>
#include <stdio.h>
#include <iostream>
using namespace std;

__global__ void dkernel(int N, int* da)
{
	da[threadIdx.x * N] = threadIdx.x;
	printf("\n data[%d] = %d", (threadIdx.x * N), (da[threadIdx.x * N]));
}
int main()
{
	cout << "\n Enter the degree of coalscing(1-32) ";
	int N, * da;
	cin >> N;
	cudaMalloc(&da, sizeof(int) * N * 32);
	dkernel << <1, 32 >> > (N,da);
	cudaDeviceSynchronize();
	cout << "\n Programe with coalscing " << N << "  created";
	return 0;

}

