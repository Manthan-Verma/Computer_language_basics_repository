#include<iostream>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include<cuda.h>
#include <stdio.h>
#include<stdlib.h>
__global__ void dod()
{
	int i = threadIdx.x;
	if (i<10)
	{
		printf("\n Hello %d ", i);
		if (i==1)
		{
			printf("\n thread1 ", i);
		}
		else if(i==2)
		{
			printf("\n thread 2 ", i);
		}
	}
	else
		if (i==25)
		{
			printf("\n thread25 %d ", i);
		}
		else
			printf("\n waste %d ", i);
}
int main()
{
	dod << <1, 32 >> > ();
	cudaDeviceSynchronize();
	return 0;
}