
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <cuda.h>
#include <stdio.h>
#include<iostream>
#include<complex>
#include<algorithm>
using namespace std;

__global__
void cal(complex<float>* dcoordinates, int N, float* max)
{
	int i = threadIdx.x;
	complex<float> mag=0;
	for (int j = i; j < N; j++)
	{
		complex<float> k = dcoordinates[i] - dcoordinates[j];
		if (norm(k) > norm(mag))
		{
			mag = k;
		}
	}
	max[i] = norm(mag);
}
int main()
{
	int N;
	cout << "\n Enter the no of positions to cal coordinates for ";
	cin >> N;
	complex<float>* hcoordinates, * dcoordinates;
	float* max, * hmax;
	hmax = new float[N - 1];											// Max on host 
	cudaMalloc(&max, sizeof(float) * (N - 1));								// Assigning value to device 
	cudaMalloc(&dcoordinates, sizeof(complex<float>) * N);					//  DEVICE MEMORY ALLOCATION
	hcoordinates = new complex<float>[N];									// HOST MEMORY ALLOCATION
	for (int i = 0; i < N; i++)
	{
		cout << "\n Enter the " << i << "th coordinates x and then y \n";
		cin >> hcoordinates[i];
		cout << "\n Entered value is " << hcoordinates[i];
	}
	cudaMemcpy(dcoordinates, hcoordinates, sizeof(complex<float>) * N, cudaMemcpyHostToDevice);   // Memory copy from Host to Device
	cal << <1, (N - 1) >> > (dcoordinates, N, max);
	cudaMemcpy(hmax, max, sizeof(float) * (N - 1), cudaMemcpyDeviceToHost);
	float* maximum = max_element(hmax, hmax + N - 1);
	cout << "\n Max distance is " << maximum[0];
	return 0;

}

