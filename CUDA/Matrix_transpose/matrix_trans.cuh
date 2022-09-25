#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include "cuda.h"
#include <iostream>
#include <math.h>
#include <stdio.h>
constexpr int Nx{3};
constexpr int Ny{2};
constexpr int Nz{4};
constexpr int procs{2};
constexpr int Total_data_size = Nx*Ny*Nz;
constexpr int d{(Nx / procs) * Ny};
constexpr int d_tmp{Nx/procs};
constexpr int d_tmp_z{Nz/procs};


__global__ void transpose_y_z_with_x_fixed(float2 *matrix, float2 *matrix_transpose)
{
    int i = threadIdx.x + ( blockDim.x * blockIdx.x);
    int coloum = i % Nx;
    int multiply_no = i / Nx;
    int row = multiply_no % Ny;
    int slab_front = i / (Nx * Ny);
    int j = (row * Nx * Nz) + (slab_front * Nx) + coloum;
    matrix_transpose[j] = matrix[i];
}
void Matrix_transpose_gpu(float2 *data);
void Matrix_transpose_cpu(float2 *data);
void matrix_dim_change_cpu(float2 *data);
void matrix_transpose_cpu_slab(float2 *data);
void reverse_testing_slab(float2* data);