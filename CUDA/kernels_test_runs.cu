#include <iostream>
#include <cufft.h>
#include <cuda.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <complex>
#include <stdio.h>
#include <string>
#include <algorithm>
#include <memory.h>


__constant__ int x_gpu, y_gpu, z_gpu;

constexpr int Nx{512}, Ny{512}, Nz{512};
constexpr int procs{8};

float total_time{0};
cufftComplex *h_data, *d_data, *d_transpose;

cudaEvent_t start, stop;

extern "C++" inline void gpuerrcheck_cudaerror(cudaError_t err, int line) // CUFFT ERROR CHECKER
{
    if (err != 0)
    {
        std::cout << "\n cuda error  = " << cudaGetErrorString(err) << " , At line " << line;
        exit(0);
    }
}

__global__ void exp()
{
    printf("\n threadidx.x , threadidx.y , threadidx.z = %d , %d , %d", threadIdx.x, threadIdx.y, threadIdx.z);
}

__global__ void chunk_transpose(cufftComplex *matrix_data, cufftComplex *matrix_transpose)
{
    long long int i = (blockDim.x * blockIdx.x) + threadIdx.x;
    int d_tmp_z = Nz / procs;
    int Nx_no = i % Nx;
    int Ny_no = (i / Nx) % Ny;
    int Nz_no = i / (Nx * Ny);
    int odd_even = Nz_no / d_tmp_z;
    int put_odd_even = Nz_no % d_tmp_z;
    long long int put_no_slab = (odd_even * Ny * Nx * Nz / procs) + (put_odd_even * Nx) + (Ny_no * Nx * Nz / procs);
    long long int put_no_full = put_no_slab + Nx_no;
    matrix_transpose[put_no_full] = matrix_data[i];
}

__global__ void copy_kernel(cufftComplex *matrix_data, cufftComplex *matrix_transpose)
{
    long long int i = threadIdx.x + (blockDim.x * blockIdx.x);
    matrix_transpose[i] = matrix_data[i];
}

__global__ void transpose_slab_type0(cufftComplex *matrix_data, cufftComplex *matrix_transpose)
{
    __shared__ cufftComplex data[256];

    long long int i = threadIdx.x + (blockDim.x * blockIdx.x);
    int z = i % (z_gpu / 2 + 1);
    int y = (i / (z_gpu / 2 + 1)) % Ny;
    int x = (i / ((z_gpu / 2 + 1) * Ny));
    long long int put_no = (x * (z_gpu / 2 + 1)) + (y * (z_gpu / 2 + 1) * Nx) + z;
    
    matrix_transpose[put_no] = matrix_data[i];

    //__syncthreads();
    
    //matrix_transpose[put_no] = data[threadIdx.x];
}
__global__ void transpose_slab_type1(cufftComplex *matrix_data, cufftComplex *matrix_transpose)
{
    __shared__ cufftComplex data[16][16];
    int z = blockIdx.x;
    int y = threadIdx.y + (blockIdx.y * blockDim.y);
    int x = threadIdx.z + (blockDim.z * blockIdx.z);

    long long int input = (x * Ny * (Nz/2+1) ) + (y * (Nz/2+1) )  + z;

    long long int output = (y * (Nz/2+1) * Nx) + (x * (Nz/2+1)) + z;
    

    data[threadIdx.x][threadIdx.y] = matrix_data[input];
    
    __syncthreads();
    
    matrix_transpose[output] = data[threadIdx.x][threadIdx.y];
}
__global__ void transpose_slab_type2(cufftComplex *matrix_data, cufftComplex *matrix_transpose)
{
    __shared__ cufftComplex data[16][16];
    int z = blockIdx.z;
    int y = threadIdx.y + (blockIdx.y * blockDim.y);
    int x = threadIdx.x + (blockDim.x * blockIdx.x);

    long long int input = (x * Ny * (Nz/2+1)) + (y * (Nz/2+1)) + z;

    long long int output = (y * (Nz/2+1) * Nx) + (x * (Nz/2+1)) + z;
    

    data[threadIdx.x][threadIdx.y] = matrix_data[input];
    
    __syncthreads();
    
    matrix_transpose[output] = data[threadIdx.x][threadIdx.y];
}

/*__global__ void transpose_slab_coalsced(cufftComplex *matrix_data, cufftComplex *matrix_transpose, long long int Ny, long long int Nx)
{
    __shared__ cufftComplex data[16][16];
    long long int i = (threadIdx.x * 32) + (blockDim.x * 32 * blockIdx.x);
    for (long long int loop = 0; loop < 32; loop++)
    {
        i += loop;
        int z = i % (z_gpu / 2 + 1);
        int y = (i / (z_gpu / 2 + 1)) % Ny;
        int x = (i / ((z_gpu / 2 + 1) * Ny));
        long long int put_no = (x * (z_gpu / 2 + 1)) + (y * (z_gpu / 2 + 1) * Nx) + z;
        matrix_transpose[put_no] = matrix_data[i];
    }
}*/

void init_var()
{
    h_data = (cufftComplex *)malloc(sizeof(cufftComplex) * Nx * Ny * Nz);
    for (int i = 0; i < Nx; i++)
    {
        //std::cout << "\n\n";
        for (int j = 0; j < Ny; j++)
        {
            //std::cout << "\n";
            for (int k = 0; k < Nz; k++)
            {
                h_data[(i * Ny * Nz) + (j * Nz) + k].x = rand() % 10;
                h_data[(i * Ny * Nz) + (j * Nz) + k].y = rand() % 10;
                //std::cout << "  " << data[(i * Ny * Nz) + (j * Nz) + k].x << "," << data[(i * Ny * Nz) + (j * Nz) + k].y; //<< "(" << i << "," << j << "," << k << ")";
            }
        }
    }

    cudaMalloc(&d_data, sizeof(cufftComplex) * Nx * Ny * Nz);
    gpuerrcheck_cudaerror(cudaGetLastError(), __LINE__ - 1);

    cudaMalloc(&d_transpose, sizeof(cufftComplex) * Nx * Ny * Nz);
    gpuerrcheck_cudaerror(cudaGetLastError(), __LINE__ - 1);
}
int main()
{
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    init_var();

    dim3 grid_chunk{(Nz/2+1)*Ny*Nx/256,1,1};
    dim3 block_chunk{256,1,1};

    dim3 grid_copy{(Nz/2+1)*Ny*Nx/256,1,1};
    dim3 block_copy{256,1,1};

    dim3 grid_slab_type0{(Nz/2+1)*Ny*Nx/256,1,1};
    dim3 block_slab_type0{256,1,1};

    dim3 grid_slab_type1((Nz/2+1),Ny/16,Nx/16);
    dim3 block_slab_type1(1,16,16);

    dim3 grid_slab_type2(Nx / 16 , Ny / 16, (Nz / 2 + 1));
    dim3 block_slab_type2(16, 16, 1);
    
    //dim3 grid_slab_c((Nz / 2 + 1) * Ny * Nx / (256 * 32), 1, 1);
    //dim3 block_slab_c(256, 1, 1);

    cudaMemcpyToSymbol(x_gpu, &Nx, sizeof(int));
    gpuerrcheck_cudaerror(cudaGetLastError(), __LINE__ - 1);
    cudaMemcpyToSymbol(y_gpu, &Ny, sizeof(int));
    gpuerrcheck_cudaerror(cudaGetLastError(), __LINE__ - 1);
    cudaMemcpyToSymbol(z_gpu, &Nz, sizeof(int));
    gpuerrcheck_cudaerror(cudaGetLastError(), __LINE__ - 1);

    // warmp up
    transpose_slab_type1<<<grid_slab_type1, block_slab_type1>>>(d_data, d_transpose);
    transpose_slab_type2<<<grid_slab_type2, block_slab_type2>>>(d_data, d_transpose);
    

    // Actual computation

    cudaEventRecord(start);
    for (int i = 0; i < 100; i++)
    {
        copy_kernel<<<grid_copy, block_copy>>>(d_data, d_transpose);
    }
    cudaEventRecord(stop);
    cudaEventSynchronize(stop);
    cudaEventElapsedTime(&total_time, start, stop);
    std::cout << "\n total time copy kernel = " << total_time / 100 << " ms";

    cudaEventRecord(start);
    for (int i = 0; i < 100; i++)
    {
        transpose_slab_type0<<<grid_slab_type0, block_slab_type0>>>(d_data, d_transpose);
    }
    cudaEventRecord(stop);
    cudaEventSynchronize(stop);
    cudaEventElapsedTime(&total_time, start, stop);
    std::cout << "\n total time type0 = " << total_time / 100 << " ms";
    
    /*cudaEventRecord(start);
    for (int i = 0; i < 100; i++)
    {
        transpose_slab_type1<<<grid_slab_type1, block_slab_type1>>>(d_data, d_transpose);
    }
    cudaEventRecord(stop);
    cudaEventSynchronize(stop);
    cudaEventElapsedTime(&total_time, start, stop);
    std::cout << "\n total time type1 = " << total_time / 100 << " ms";

    cudaEventRecord(start);
    for (int i = 0; i < 100; i++)
    {
        transpose_slab_type2<<<grid_slab_type2, block_slab_type2>>>(d_data, d_transpose);
    }
    cudaEventRecord(stop);
    cudaEventSynchronize(stop);
    cudaEventElapsedTime(&total_time, start, stop);
    std::cout << "\n total time type2  = " << total_time / 100 << " ms";*/

    cudaEventRecord(start);
    for (int i = 0; i < 100; i++)
    {
        chunk_transpose<<<grid_chunk, block_chunk>>>(d_data, d_transpose);
    }
    cudaEventRecord(stop);
    cudaEventSynchronize(stop);
    cudaEventElapsedTime(&total_time, start, stop);
    std::cout << "\n total time chunk = " << total_time / 100 << " ms";

    return 0;
}