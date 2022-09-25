
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <cuda.h>
#include <stdio.h>
#include <iostream>
#include <device_functions.h>
#include <cuda_runtime_api.h>
#include <curand_kernel.h>
using namespace std;

__global__ void shared()
{
	__shared__ int s;											// THIS VAR IS SHARED ACROSS ALL THREADS IN A THREADBLOCK
	if (threadIdx.x == 0)
		s = 0;
	if (threadIdx.x == 1)
		s += 1;
	if (threadIdx.x == 100)
		s += 2;
	if (threadIdx.x == 0)
		printf("\n S = %d", s);
}

__global__ void shared_barrier()
{
	__shared__ int s;											// THIS VAR IS SHARED ACROSS ALL THREADS IN A THREADBLOCK
	if (threadIdx.x == 0)
	{
		s = 0;
	}
	if (threadIdx.x == 1)
	{
		s += 1;
	}
	__syncthreads();

	if (threadIdx.x == 100)
	{
		s += 2;
	}
	__syncthreads();

	if (threadIdx.x == 0)
	{
		printf("\n S = %d", s);
	}
}

__global__ void classeg(int* matrix,int Threadsize)
{
	__shared__ int a[1024];
	if (threadIdx.x < 1023)
	{
		a[threadIdx.x] = matrix[(blockIdx.x * blockDim.x) + threadIdx.x] + matrix[(blockIdx.x * blockDim.x) + threadIdx.x + 1];
		__syncthreads();
		matrix[(blockIdx.x * blockDim.x) + threadIdx.x] = a[threadIdx.x];
	}
}


/*int main()
{
	/*int Blocksize = 1024, Threadsize = 1024, * matrix, * hmatrix;
	hmatrix = new int[1024 * 1024];
	cudaMalloc(&matrix, sizeof(int) * 1024 * 1024);
	for (int i = 0; i < 1024*1024; i++)
	{
		hmatrix[i] = i;
	}
	cudaMemcpy(matrix, hmatrix, sizeof(int) * 1024 * 1024, cudaMemcpyHostToDevice);
	shared_barrier << <100, Blocksize >> > ();
	cudaDeviceSynchronize();
	classeg << <Blocksize, Threadsize >> > (matrix,Threadsize);
	cudaDeviceSynchronize();*/
	
	
	/*shared_barrier << <200, 1000 >> > ();
	
	cudaDeviceSynchronize();
	return 0;
}*/


//								FOR DYNAMIC SHARED MEMEORY

__global__ void dyshared(int* data)
{
	extern __shared__ int m[];						// shared inside a threadblock 
	m[threadIdx.x] = data[threadIdx.x];
	printf("\n value at %d = %d", threadIdx.x, m[threadIdx.x]);
}

//								 Dynamic Multi-shared
__global__ void dykernel()
{
	extern __shared__ int s[];
	int* p1{ s };
	int* p2{ s + 1 };
	int* p3{ s + 2 };
	if (threadIdx.x == 0)
	{
		s[threadIdx.x] = 0;
		s[threadIdx.x + 1] = 1;
		s[threadIdx.x + 2] = 2;
	}
	else
	{
		printf("\n data = %d  ,  %d ,  %d", *p1, *p2, *p3);
	}

}
int main()
{
	int a;
	std::cout << "enter the no of elements to be shared memeory (is to be <= 1024)";
	std::cin >> a;
	int* data,* data_passed;
	data = new int[1024];

	// Setup for shared memeory 
	//cudaDeviceSetCacheConfig(cudaFuncCachePreferL1);   // ----> This is used for setting the cach configration for all kernels
	cudaFuncSetCacheConfig(dyshared, cudaFuncCachePreferShared);   //-----> This is used for the setting of cache configration for perticular kernel 
	// Here cudaDuncCacheprefershared --> gives all cache to shared 
	//		cudaFuncCachePreferEqual		--> divides L1 and shared equally among processes
	//		cudaFuncCachePreferNone		---->  Default configration of L1 and shared 
	//		cudaFuncCachePreferL1  ---> all cache memory to L1


	for (int i = 0; i < 1024; i++)
	{
		data[i] = i;
	}
	if (cudaMalloc(&data_passed, sizeof(int) * 1024) != cudaSuccess)
	{
		std::cout << "\nmemeory allocation failed in gpu ";
		return 0;
	}

	if (cudaMemcpy(data_passed, data, sizeof(int) * 1024, cudaMemcpyHostToDevice) != cudaSuccess)
	{
		std::cout << "\n memory copy failed from host to device";
		return 0;
	}

	dyshared << <1, a, sizeof(int)* a >> > (data_passed);				// ------> Here third parameter is used for passing the shared memory size to kernel 
	if (cudaGetLastError() != cudaSuccess)
	{
		std::cout << "\n Kernel launch error ";
		return 0;
	}
	cudaDeviceSynchronize();

	dykernel << <1, a, sizeof(int)* a >> > ();				// ------> Here third parameter is used for passing the shared memory size to kernel 
	if (cudaGetLastError() != cudaSuccess)
	{
		std::cout << "\n Kernel launch error ";
		return 0;
	}
	return 0;
}