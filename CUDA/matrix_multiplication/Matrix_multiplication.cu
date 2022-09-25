
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include "cuda.h"
#include <stdio.h>
#include <iostream>
#include <chrono>
#include <stdlib.h>
#include <stdio.h>
using namespace std;
using namespace std::chrono;
const int N1 = 1000;
const int N2 = 1000;

																								//   GPU ASSIGN_DATA KERNEL

__global__ void assign_data(int* matrix1, int* matrix2)
{
	int i = threadIdx.x + (blockDim.x * blockIdx.x);
	//printf("\n threadidx.x = %d , blockidx.x = %d  , blockdim.x = %d  , griddim.x = %d , i = %d", threadIdx.x,blockIdx.x,blockDim.x,gridDim.x,i);
	matrix1[i] = matrix2[i] = i;
}


																							//  GPU DATA MULTIPLICATION EXECUTION SEQUENTIAL 2D


__global__ void multiply_data_seq_2d(int* matrix1, int* matrix2, int* result)
{
	for (int i = 0; i < N1; i++)
	{
		for (int j = 0; j < N1; j++)
		{
			result[i * N1 + j] = 0;
			for (int k = 0; k < N2; k++)
			{
				result[i * N1 + j] += matrix1[i * N2 + k] * matrix2[k * N1 + j];
			}
		}
	}
}

																							
																							//  GPU DATA MULTIPLICATION EXECUTION SEQUENTIAL 1D

__global__ void multiply_data_seq_1d(int* matrix1, int* matrix2, int* result)
{
	for (int i = 0; i < N1*N2; i++)
	{
		result[i] += matrix1[i] * matrix2[i];
	}
}


																							// PARALLEL EXECUTION OF MATRIX MULTIPLICATION ON GPU 2D


__global__ void multiply_parallel(int* matrix1, int* matrix2, int* result)
{
	result[blockIdx.x * gridDim.x + threadIdx.x] = 0;
	for (int k = 0; k < N2; k++)
	{
		result[blockIdx.x * gridDim.x + threadIdx.x] += matrix1[blockIdx.x * blockDim.x + k] * matrix2[k * gridDim.x + threadIdx.x];
	}
}

																								//  CPU COMPUTATION RESULTS 
void matrixsquare()
{
	int hmatrix1[N1][N2], hmatrix2[N2][N1], hmatrixr[N1][N1] = { 0 }, hmatrixf[N1][N1] = { 0 };
	for (int i = 0; i < N1; i++)
	{
		for (int j = 0; j < N2; j++)
		{
			hmatrix1[i][j] = rand() % 10;							// INITIALIZNG THE HMARTIX1
			hmatrix2[j][i] = rand() % 10;							// INITIALIZE THE HMATRIX2
		}
	}
	auto start = high_resolution_clock::now();
	for (int i = 0; i < N1; i++)
	{
		for (int j = 0; j < N1; j++)
		{
			for (int k = 0; k < N2; k++)
			{
				hmatrixr[i][j] += hmatrix1[i][k] * hmatrix2[k][j];
			}
		}
	}
	auto stop = high_resolution_clock::now();
	auto start1 = high_resolution_clock::now();
	for (int i = 0; i < N1; i++)
	{
		for (int k = 0; k < N2; k++)
		{
			for (int j = 0; j < N1; j++)
			{
				hmatrixf[i][j] += hmatrix1[i][k] * hmatrix2[k][j];
			}
		}
	}
	auto stop1 = high_resolution_clock::now();
	auto duration = duration_cast<microseconds>(stop - start) / 1e3;
	auto duration1 = duration_cast<microseconds>(stop1 - start1) / 1e3;
	cout << "\n Total time taken by the loop for multiplication("<<N1<<") X ("<<N2<<") on cpu with row major approch  is = " << duration.count() << " milliseconds \n";
	cout << "\n Total time taken by the loop for multiplication(" << N1 << ") X (" << N2 << ") on cpu with row coloum approch  is = " << duration1.count() << " milliseconds \n";
}

																									
																								//  GPU COMPUTATION RESULTS 

void GPU_cmputation()
{
	int* matrix1, * matrix2, * result, * result_1d;
	cudaMalloc(&matrix1, sizeof(int) * N1 * N2);
	if (cudaGetLastError() != CUDA_SUCCESS)
	{
		cout << "\n Memory allocatio failed inside GPU";
	}
	cudaMalloc(&matrix2, sizeof(int) * N2 * N1);
	if (cudaGetLastError() != CUDA_SUCCESS)
	{
		cout << "\n Memory allocatio failed inside GPU";
	}
	cudaMalloc(&result, sizeof(int) * N1 * N1);
	if (cudaGetLastError() != CUDA_SUCCESS)
	{
		cout << "\n Memory allocatio failed inside GPU";
	}
	cudaMalloc(&result_1d, sizeof(int) * N1 * N2);
	if (cudaGetLastError() != CUDA_SUCCESS)
	{
		cout << "\n Memory allocatio failed inside GPU";
	}
	assign_data << <N1, N2 >> > (matrix1, matrix2);
	cudaDeviceSynchronize();
	auto start_seq = high_resolution_clock::now();
	//multiply_data_seq_2d << <1, 1 >> > (matrix1, matrix2, result);
	cudaDeviceSynchronize();
	auto stop_seq = high_resolution_clock::now();
	multiply_parallel << <N1, N1 >> > (matrix1, matrix2, result);
	cudaDeviceSynchronize();
	auto stop_par = high_resolution_clock::now();
	multiply_data_seq_1d << <1, 1 >> > (matrix1, matrix2, result);
	cudaDeviceSynchronize();
	auto stop_extra = high_resolution_clock::now();
	auto duration_seq = duration_cast<microseconds>(stop_seq - start_seq) / 1e3;
	auto duration_par = duration_cast<microseconds>(stop_par - stop_seq) / 1e3;
	auto duration_extra = duration_cast<microseconds>(stop_extra - stop_par) / 1e3;
	cout << "\n Total time taken by the loop for multiplication(" << N1 << ") X (" << N2 << ") on cpu with row major approch  sequential execution on GPU  is = " << duration_seq.count() << " milliseconds \n";
	cout << "\n Total time taken by the loop for multiplication(" << N1 << ") X (" << N2 << ") on cpu with row major approch  parallel execution on GPU is = " << duration_par.count() << " milliseconds \n";
	cout << "\n Total time taken by the loop for multiplication(" << N1 << ") X (" << N2 << ") on cpu with row major approch  parallel execution on GPU is = " << duration_extra.count() << " milliseconds \n";
}
int main()
{
	//cout << "\n Following results are for CPU COMPUTATION \n";
	//matrixsquare();
	cout << "\n \n Following results are for GPU COMPUTATION \n";
	GPU_cmputation();
	return 0;
}