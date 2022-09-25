#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <cuda.h>
#include <stdio.h>
#include <iostream>
#include <complex>
#include <math.h>
#include <random>
using namespace std;

__global__ void euclidean(float2* ddist, float* check, int total)
{
	float dist = 0, t = 0;
	float2 c;
	c.x = c.y = 0;
	/*for (int i = 0; i < total; i++)
	{
		printf("\n data for thread is %f,  %f ", ddist[threadIdx.x].x, ddist[threadIdx.x].y);
		printf("\n distance data thread %d = %f   %f ", threadIdx.x, ddist[i].x, ddist[i].y);
	}*/
	for (int j = threadIdx.x+1 ; j < total; j++)
	{
		c.x = (ddist[j].x - ddist[threadIdx.x].x)* (ddist[j].x - ddist[threadIdx.x].x);
		c.y = (ddist[j].y - ddist[threadIdx.x].y)* (ddist[j].y - ddist[threadIdx.x].y);
		t = c.x + c.y;
		//printf("\n thread %d distance %f    %f   %f", threadIdx.x, c.x, c.y,t);
		t = sqrt(t);
		if (t > dist)
		{
			dist = t;
		}
	}
	check[threadIdx.x] = dist;
}

__global__ void max(float* check, int total)
{
	float c = 0;
	for (int i = 0; i < total-1; i++)
	{
		printf("\n val = %f", check[i]);
		if (check[i] > c)
		{
			c = check[i];
		}
	}
	printf("\n max distance is %f", c);
}
int main()
{
	const int N = 5;
	float2* hdist, * ddist;
	float* check;
	hdist = new float2[N];
	for (int i = 0; i < N; i++)
	{
		hdist[i].x = rand() % 10;
		hdist[i].y = rand() % 5;
		//cout << "\n Data is " << hdist[i].x <<"  "<< hdist[i].y;
	}
	cudaMalloc(&ddist, sizeof(float2) * N);
	cudaMalloc(&check, sizeof(float) * (N - 1));
	cudaMemcpy(ddist, hdist, sizeof(float2) * N, cudaMemcpyHostToDevice);
	euclidean << <1, N-1 >> > (ddist, check, N);
	cudaDeviceSynchronize();
	max << <1, 1 >> > (check, N);
	cudaDeviceSynchronize();
	return 0;
}
