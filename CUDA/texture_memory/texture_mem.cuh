#include <iostream>
#include <cuda.h>
#include <cuda_runtime.h>
#include <device_launch_parameters.h>

int Nx{2}, Ny{2};

texture<float, 2, cudaReadModeElementType> tex;        // Here 2 -> is no of dimensions of variable ,  float is type of variable 
texture<float, 3, cudaReadModeElementType> tex3;        // Here 2 -> is no of dimensions of variable ,  float is type of variable 


__global__ void t(cudaArray * array);
__global__ void t();
//texture<float,1,cudaReadModeElementType> tex;           // Here 1 -> is no of dimensions of variable ,  float is type of variable 
