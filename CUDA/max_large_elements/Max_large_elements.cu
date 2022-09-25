#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <cuda.h>
#include <stdio.h>
#include <iostream>
#include <random>
#include <math.h>
#include <chrono>

using namespace std;
using namespace std::chrono;

__global__ void dkernel(float* darr, int k)
{
	float c = 0;
	for (int i = k*threadIdx.x ; i < k*(threadIdx.x+1); i++)
	{
		if (darr[i] > c)
		{
			c = darr[i];
		}
	}
	darr[threadIdx.x * k] = c;
	printf("\n thread is %d , c = %f", threadIdx.x, darr[threadIdx.x * k]);
}
int main()
{
	const int N = 10000;
	int k = 1000,block;
	float* harr, * darr;
	harr = new float[N];
	cudaMalloc(&darr, sizeof(float) * N);
	//cudaMalloc(&data, sizeof(float) * (N / k));
	for (int i = 0; i < N; i++)
	{
		harr[i] = rand() % 20;
		cout << "\n data is " << harr[i];
	}
	block = N / k;
	cudaMemcpy(darr, harr, sizeof(float) * N, cudaMemcpyHostToDevice);
	dkernel << <1, N / k >> > (darr, k);
	cudaDeviceSynchronize();
	dkernel << <1, 1 >> > (darr, N);
	return 0;
}