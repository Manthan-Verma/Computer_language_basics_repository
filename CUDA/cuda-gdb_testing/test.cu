#include<iostream>
#include<cuda.h>
#include<cuda_runtime.h>
#include<device_launch_parameters.h>

__global__ void k(int* p)
{
    *p =0;
    printf("\n *p = %d",*p);
}

int main()
{
    int * x, * y;
    cudaMalloc(&x,sizeof(int));
    k<<<2,10>>>(x);
    cudaDeviceSynchronize();
    y = x;
    cudaFree(y);
    k<<<2,10>>>(y);
    cudaDeviceSynchronize();
    return 0;
}