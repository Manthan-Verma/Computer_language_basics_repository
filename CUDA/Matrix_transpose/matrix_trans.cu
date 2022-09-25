#include "matrix_trans.cuh"

__global__ void trans2_cut_with_y(float2 *matrix_data, float2 *matrix_transpose)
{
    int i = (blockDim.x * blockIdx.x) + threadIdx.x;
    int no = i / d;
    int k = i - (no * d);
    int j = ((k % (Nx)) * (Ny/procs)) + (k / (Nx));
    int l = (no * d) + j;
    matrix_transpose[l] = matrix_data[i];
}

__global__ void trans2_cut_with_x(float2 *matrix_data, float2 *matrix_transpose)
{
    int i = (blockDim.x * blockIdx.x) + threadIdx.x;
    int Nx_no = i % Nx;
    int Ny_no = (i/Nx)%Ny;
    int Nz_no = i / (Nx*Ny);
    int odd_even = Nx_no/d_tmp;
    int put_odd_even = Nx_no%d_tmp;
    int put_no_slab = (put_odd_even*Ny*procs) + (Ny*odd_even) + Ny_no ;
    int put_no_full = put_no_slab + (Nz_no*(Nx*Ny));
    matrix_transpose[put_no_full] = matrix_data[i];
}

__global__ void trans2_cut_with_z_allocated_along_x(float2 *matrix_data, float2 *matrix_transpose)
{
    int i = (blockDim.x * blockIdx.x) + threadIdx.x;
    int Nx_no = i % Nx;
    int Ny_no = (i/Nx)%Ny;
    int Nz_no = i / (Nx*Ny);
    int Real_Nz_no = Nz - Nz_no-1;
    int odd_even = Nz_no/d_tmp_z;
    int put_odd_even = Nz_no % d_tmp_z;
    int put_no_slab = (odd_even*Ny*Nx*Nz/procs) + (put_odd_even*Nx) + (Ny_no*Nx*Nz/procs);
    int put_no_full = put_no_slab + Nx_no;
    matrix_transpose[put_no_full] = matrix_data[i];
}

__global__ void trans2_cut_with_z_reverse_allocated_along_x(float2 *matrix_data, float2 *matrix_transpose)
{
    int i = (blockDim.x * blockIdx.x) + threadIdx.x;
    int Nx_no = i % Nx;
    int Ny_no = (i/Nx)%(Nz/procs);
    int Nz_no = i / (Nx*(Nz/procs));
    //int Real_Nz_no = Nz - Nz_no-1;
    int odd_even = Nz_no/Ny;
    int put_odd_even = (Nz_no % Ny);
    int put_no_slab = (odd_even*Ny*Nx*Nz/procs) + (put_odd_even*Nx) + (Ny_no*Nx*Ny);
    int put_no_full = put_no_slab + Nx_no;
    matrix_transpose[put_no_full] = matrix_data[i];
}
__global__ void transpose(float2 *matrix_data, float2 *matrix_transpose)
{
    long long int i = threadIdx.y + (blockDim.y * threadIdx.x) + (blockIdx.x * blockDim.x * blockDim.y);
    long long int j = (threadIdx.y * blockDim.x) + threadIdx.x + (blockIdx.x * blockDim.x * blockDim.y);
    matrix_transpose[j].x = matrix_data[i].x;
    matrix_transpose[j].y = matrix_data[i].y;
}

__global__ void transpose_slab(float2 *matrix_data, float2 *matrix_transpose)
{
    int i = threadIdx.x + (blockDim.x*blockIdx.x) + (blockIdx.y*gridDim.x*blockDim.x);
    int j = ((threadIdx.x*gridDim.x)+blockIdx.x)+(blockIdx.y*blockDim.x*gridDim.x);
    matrix_transpose[i]=matrix_data[j];
}
__global__ void transpose_slab_in_z_y_dir(float2 *matrix_data, float2* matrix_transpose)
{
    long long int i = threadIdx.x + (blockDim.x * blockIdx.x);
    int z = i % Nz;
    int y = (i / Nz) % Ny;
    int x = (i / (Nz*Ny));
    long long int put_no = (x*Nz) + (y * Nz * Nx) + z;
    matrix_transpose[put_no] = matrix_data[i];
}
void test2(float2* data)
{
    float2* transpose,* check;
    check = (float2*)calloc(Nx*Ny*Nz,sizeof(float2));
    cudaMalloc(&transpose,sizeof(float2)*Nx*Ny*Nz);
    cudaDeviceSynchronize();
    //dim3 block(Ny,1,1);
    //dim3 grid(Nx,Nz,1);
    //transpose_slab<<<grid,block>>>(data,transpose);
    transpose_slab_in_z_y_dir<<<1,(Nx*Ny*Nz)>>>(data,transpose);

    cudaMemcpy(check,transpose,sizeof(float2)*Nx*Ny*Nz,cudaMemcpyDeviceToHost);
    std::cout << "\n\n data we got after transpose = ";
    for (int i = 0; i < Ny; i++)
    {
        std::cout << "\n\n";
        for (int j = 0; j < Nx; j++)
        {
            std::cout << "\n";
            for (int k = 0; k < Nz; k++)
            {
                std::cout << "  " << check[(i * Nx * Nz) + (j * Nz) + k].x << "," << check[(i * Nx * Nz) + (j * Nz) + k].y;
            }
        }
    }

}
void Matrix_transpose_gpu(float2 *data)
{
    //dim3 block{Ny, Nz, 1};
    //dim3 grid{Nx, 1, 1};
    float2 *matrix_transpose_gpu, *matrix_transpose_gpu_check;
    matrix_transpose_gpu_check = (float2 *)malloc(sizeof(float2) * Nx * Nz * Ny);

    if (cudaMalloc(&matrix_transpose_gpu, sizeof(float2) * Nx * Ny * Nz) != cudaSuccess)
    {
        std::cout << "\n Failed to allocate memory on gpu for transpose ";
        return;
    }

    trans2_cut_with_z_allocated_along_x<<<1, (Nx * Ny * Nz)>>>(data, matrix_transpose_gpu);

    trans2_cut_with_z_reverse_allocated_along_x<<<1, (Nx * Ny * Nz)>>>(matrix_transpose_gpu, data);

    if (cudaMemcpy(matrix_transpose_gpu_check, data, sizeof(float2) * Nx * Nz * Ny, cudaMemcpyDeviceToHost) != cudaSuccess)
    {
        std::cout << "\n failed to copy data from device to host ";
        return;
    }

    std::cout << "\n \n Matrix Transpose gpu :: ";
    for (int i = 0; i < Nz; i++)
    {
        std::cout << "\n\n";
        for (int j = 0; j < Ny; j++)
        {
            std::cout << "\n";
            for (int k = 0; k < Nx; k++)
            {
                std::cout << "  " << matrix_transpose_gpu_check[(i * Ny * Nx) + (j * Nx) + k].x << "," << matrix_transpose_gpu_check[(i * Ny * Nx) + (j * Nx) + k].y;
            }
        }
    }
}

void Matrix_transpose_cpu(float2 *data)
{
    float2 *matrix_transpose_cpu;
    matrix_transpose_cpu = (float2 *)malloc(sizeof(float2) * Nx * Ny * Nz);

    std::cout << "\n Matrix Transpose  CPU :: ";
    for (int i = 0; i < Nx * Ny * Nz; i++)
    {
        long long int no = i / d;
        long long int k = i - (no * d);
        long long int j = ((k % Nx) * (Ny / procs)) + (k / Nx);
        long long int l = (no * d) + j;
        matrix_transpose_cpu[l] = data[i];
    }
    
    for (int i = 0; i < (Nx * Ny * Nz); i++)
    {
        int no_slab1 = i / ((Ny/procs) * (Nx*procs));
        int no_pencil = i % (Nx*procs);
        int h = i / (Nx*procs);
        h %= (Ny/procs);
        int j = (no_slab1 * (Ny/procs) * (Nx*procs)) + (no_pencil * (Ny/procs)) + h;
        data[i] = matrix_transpose_cpu[j];
    }
    for (int i = 0; i < Nz; i++)
    {
        std::cout << "\n\n";
        for (int j = 0; j < (Ny / procs); j++)
        {
            std::cout << "\n";
            for (int k = 0; k < (Nx*procs); k++)
            {
                std::cout << "  " << data[(i * (Ny / procs) * (Nx * procs)) + (j * (Nx*procs)) + k].x << "," << data[(i * (Nx * procs) * (Ny / procs)) + (j * (Nx*procs)) + k].y;
            }
        }
    }
    reverse_testing_slab(data);
}

void matrix_dim_change_cpu(float2 *data)
{
    float2 *matrix_dim_change_cpu;
    matrix_dim_change_cpu = (float2 *)malloc(sizeof(float2) * Nx * Ny * Nz);
    // rotating a matrix from x*y*z to anti-clockwise wrt y axis 90degree
    std::cout << "\n Matrix DIM CHANGE CPU :: ";
    for (int i = 0; i < Nx * Ny * Nz; i++)
    {
        int j{(i % Nz)};
        int k{i / (Nz)};
        k %= Ny;
        int h{i / (Nz * Ny)};
        long long int m{(j * Nx * Ny) + (k * Nx) + h};
        //std::cout << "\n j = " << j << " , k = " << k << " , h = " << h << "        ,m = " << m;

        matrix_dim_change_cpu[i] = data[m];
    }
    for (int i = 0; i < Nx; i++)
    {
        std::cout << "\n\n";
        for (int j = 0; j < Ny; j++)
        {
            std::cout << "\n";
            for (int k = 0; k < Nz; k++)
            {
                std::cout << "   " << matrix_dim_change_cpu[(i * Ny * Nz) + (j * Nz) + k].x << "," << matrix_dim_change_cpu[(i * Ny * Nz) + (j * Nz) + k].y;
            }
        }
    }
    for (int i = 0; i < Nx * Ny * Nz; i++)
    {
        int j{(i % Nx)};
        int k{i / (Nx)};
        k %= Ny;
        int h{i / (Nx * Ny)};
        long long int m{(j * Nz * Ny) + (k * Nz) + h};
        //std::cout << "\n j = " << j << " , k = " << k << " , h = " << h << "        ,m = " << m;

        data[i] = matrix_dim_change_cpu[m];
    }
    for (int i = 0; i < Nz; i++)
    {
        std::cout << "\n\n";
        for (int j = 0; j < Ny; j++)
        {
            std::cout << "\n";
            for (int k = 0; k < Nx; k++)
            {
                std::cout << "   " << data[(i * Ny * Nx) + (j * Nx) + k].x << "," << data[(i * Ny * Nx) + (j * Nx) + k].y;
            }
        }
    }
}

void reverse_testing_slab(float2* data)
{
    float2 *transpose = (float2*)calloc(Nx * Ny * Nz,sizeof(float2));
    for (int i = 0; i < (Nx * Ny * Nz); i++)
    {
        int no_slab1 = i / ((Nx*procs) * (Ny/procs));
        int no_pencil = i % (Ny/procs);
        int h = i / (Ny/procs);
        h %= (Nx*procs);
        int j = (no_slab1 * (Nx*procs) * (Ny/procs)) + (no_pencil * (Nx*procs)) + h;
        transpose[i] = data[j];
    }
    for (int i = 0; i < Nx * Ny * Nz; i++)
    {
        int no = i / d;
        int k = i - (no * d);
        int j = ((k % (Ny / procs)) * Nx) + (k / (Ny / procs));
        int l = (no * d) + j;
        data[l] = transpose[i];
    }
    std::cout << "\n matrix initiated by reversing it back = : ";
    for (int i = 0; i < Nz; i++)
    {
        std::cout << "\n\n";
        for (int j = 0; j < Ny; j++)
        {
            std::cout << "\n";
            for (int k = 0; k < Nx; k++)
            {
                std::cout << "  " << data[(i * Ny * Nx) + (j * Nx) + k].x << "," << data[(i * Ny * Nx) + (j * Nx) + k].y; //<< "(" << i << "," << j << "," << k << ")";
            }
        }
    }
}

void matrix_transpose_cpu_slab(float2 *data)
{
    float2 *transpose = (float2*)calloc(Nx * Ny * Nz,sizeof(float2));

    for (int i = 0; i < (Nx * Ny * Nz); i++)
    {
        int no_slab1 = i / (Nx * Ny);
        int no_pencil = i % Ny;
        int h = i / Ny;
        h %= Nx;
        int j = (no_slab1 * Nx * Ny) + (no_pencil * Nx) + h;
        transpose[i] = data[j];
    }
    for (int i = 0; i < Nz; i++)
    {
        std::cout << "\n\n";
        for (int j = 0; j < Nx; j++)
        {
            std::cout << "\n";
            for (int k = 0; k < Ny; k++)
            {
                std::cout << "   " << transpose[(i * Ny * Nx) + (j * Ny) + k].x << "," << transpose[(i * Ny * Nx) + (j * Ny) + k].y;
            }
        }
    }
    for (int i = 0; i < (Nx * Ny * Nz); i++)
    {
        int no_slab1 = i / (Nx * Ny);
        int no_pencil = i % Nx;
        int h = i / Nx;
        h %= Ny;
        int j = (no_slab1 * Nx * Ny) + (no_pencil * Ny) + h;
        data[i] = transpose[j];
    }
    for (int i = 0; i < Nz; i++)
    {
        std::cout << "\n\n";
        for (int j = 0; j < Ny; j++)
        {
            std::cout << "\n";
            for (int k = 0; k < Nx; k++)
            {
                std::cout << "   " << data[(i * Ny * Nx) + (j * Nx) + k].x << "," << data[(i * Ny * Nx) + (j * Nx) + k].y;
            }
        }
    }
}

void test(float2 *data)
{
    float2 *matrix_dim_change_cpu;
    matrix_dim_change_cpu = (float2 *)malloc(sizeof(float2) * Nx * Ny * Nz);
    // rotating a matrix from x*y*z to anti-clockwise wrt y axis 90degree
    std::cout << "\n Matrix DIM CHANGE CPU :: ";
    for (int i = 0; i < Nx * Ny * Nz; i++)
    {
        int j{(i % Nz)};
        int k{i / (Nz)};
        k %= Ny;
        int h{i / (Nz * Ny)};
        long long int m{(j * Nx * Ny) + (k * Nx) + h};
        //std::cout << "\n j = " << j << " , k = " << k << " , h = " << h << "        ,m = " << m;

        matrix_dim_change_cpu[i] = data[m];
    }

    for (int i = 0; i < Nx; i++)
    {
        std::cout << "\n\n";
        for (int j = 0; j < Ny; j++)
        {
            std::cout << "\n";
            for (int k = 0; k < Nz; k++)
            {
                std::cout << "   " << matrix_dim_change_cpu[(i * Ny * Nz) + (j * Nz) + k].x << "," << matrix_dim_change_cpu[(i * Ny * Nz) + (j * Nz) + k].y;
            }
        }
    }
    for (int i = 0; i < (Nx * Ny * Nz); i++)
    {
        int no_slab1 = i / (Nz * Ny);
        int no_pencil = i % Ny;
        int h = i / Ny;
        h %= Nz;
        int j = (no_slab1 * Nz * Ny) + (no_pencil * Nz) + h;
        data[i] = matrix_dim_change_cpu[j];
    }

    for (int i = 0; i < Nx; i++)
    {
        std::cout << "\n\n";
        for (int j = 0; j < Nz; j++)
        {
            std::cout << "\n";
            for (int k = 0; k < Ny; k++)
            {
                std::cout << "   " << data[(i * Ny * Nz) + (j * Ny) + k].x << "," << data[(i * Ny * Nz) + (j * Ny) + k].y;
            }
        }
    }
    for (int i = 0; i < (Nx * Ny * Nz); i++)
    {
        int no_slab1 = i / (Nz * Ny);
        int no_pencil = i % Nz;
        int h = i / Nz;
        h %= Ny;
        int j = (no_slab1 * Nz * Ny) + (no_pencil * Ny) + h;
        matrix_dim_change_cpu[i] = data[j];
    }
    for (int i = 0; i < Nx; i++)
    {
        std::cout << "\n\n";
        for (int j = 0; j < Ny; j++)
        {
            std::cout << "\n";
            for (int k = 0; k < Nz; k++)
            {
                std::cout << "   " << matrix_dim_change_cpu[(i * Ny * Nz) + (j * Nz) + k].x << "," << matrix_dim_change_cpu[(i * Ny * Nz) + (j * Nz) + k].y;
            }
        }
    }
}

void transpose_wrt_x(float2 *data)
{
    float2 *transpose;
    transpose = (float2 *)malloc(sizeof(float2) * Nx * Ny * Nz);
    for (int i = 0; i < Nx * Ny * Nz; i++)
    {
        int k = (i / Nx) % Nz;
        int l = i % Nx;
        int h = i / (Nx * Nz);
        int j = (Nx * Ny * (Nz - k - 1)) + (h * Nx) + l;
        transpose[i] = data[j];
    }

    for (int i = 0; i < Ny; i++)
    {
        std::cout << "\n\n";
        for (int j = 0; j < Nz; j++)
        {
            std::cout << "\n";
            for (int k = 0; k < Nx; k++)
            {
                std::cout << "   " << transpose[(i * Nx * Nz) + (j * Nx) + k].x << "," << transpose[(i * Nx * Nz) + (j * Nx) + k].y;
            }
        }
    }
}

void transpose_wrt_x_3d(float2 *data)
{
    float2 transpose[Ny][Nz][Nx];
    //float2 transpose[Ny][Ny][Nx]
    for (int i = 0; i < Nz; i++)
    {
        std::cout << "\n\n";
        for (int j = 0; j < Ny; j++)
        {
            std::cout << "\n";
            for (int k = 0; k < Nx; k++)
            {
                transpose[j][i][k] = data[(i * Nx * Ny) + (j * Nx) + k];
                std::cout << "  " << transpose[j][i][k].x << "," << transpose[j][i][k].y;
            }
        }
    }
    std::cout << " \n\n\n " << transpose[0][2][1].x << "," << transpose[0][2][1].y;
}

void transpose_y_z_keeping_x_fixed(float2 *a)
{
    // m is dimension of fast axis , p is dimension of slow axis
    float2 *b,*c;
    cudaMalloc(&b, sizeof(float2) * Nx * Ny * Nz);
    c = (float2 *)malloc(sizeof(float2) * Nx * Ny * Nz);
    /*for (int i = 0; i < (Nx * Ny * Nz); i++)
    {
        int coloum = i % Nx;
        int multiply_no = i / Nx;
        int row = multiply_no % Ny;
        int slab_front = i / (Nx * Ny);
        int j = (row * Nx * Nz) + (slab_front * Nx) + coloum;
        b[j] = a[i];
    }*/

    transpose_y_z_with_x_fixed<<<1, Total_data_size>>>(a, b);

    cudaMemcpy(c,b,sizeof(float2)*Nx*Ny*Nz,cudaMemcpyDeviceToHost);

    std::cout << "\n data we got after transpose = "
              << "\n";
    for (int i = 0; i < Ny; i++)
    {
        std::cout << "\n\n";
        for (int j = 0; j < Nz; j++)
        {
            std::cout << "\n";
            for (int k = 0; k < Nx; k++)
            {
                std::cout << "  " << c[(i * Nx * Nz) + (j * Nx) + k].x << "," << c[(i * Nx * Nz) + (j * Nx) + k].y;
            }
        }
    }
}

void run(float2* data)
{
    float2* transpose;
    transpose= (float2*)calloc((Nx*Ny*Nz),sizeof(float2));

    for (int i = 0; i < Nx * Ny * Nz; i++)
    {
        int no = i / d;
        int k = i - (no * d);
        int j = ((k % (Ny / procs)) * Nx) + (k / (Ny / procs));
        int l = (no * d) + j;
        data[l] = transpose[i];
    }
}
int main()
{
    float2 *data, *matrix;
    data = (float2 *)malloc(sizeof(float2) * Nx * Ny * Nz);

    std::cout << "\n matrix initiated = : ";
    for (int i = 0; i < Nx; i++)
    {
        std::cout << "\n\n";
        for (int j = 0; j < Ny; j++)
        {
            std::cout << "\n";
            for (int k = 0; k < Nz; k++)
            {
                data[(i * Ny * Nz) + (j * Nz) + k].x = rand() % 10;
                data[(i * Ny * Nz) + (j * Nz) + k].y = rand() % 10;
                std::cout << "  " << data[(i * Ny * Nz) + (j * Nz) + k].x << "," << data[(i * Ny * Nz) + (j * Nz) + k].y; //<< "(" << i << "," << j << "," << k << ")";
            }
        }
    }

    if (cudaMalloc(&matrix, sizeof(float2) * Nx * Ny * Nz) != cudaSuccess)
    {
        std::cout << "\n Failed to allocate memory on gpu  for normal data ";
        return 1;
    }

    if (cudaMemcpy(matrix, data, sizeof(float2) * Nx * Ny * Nz, cudaMemcpyHostToDevice) != cudaSuccess)
    {
        std::cout << "\n failed to copy data from host to device ";
        return 1;
    }

    test2(matrix);
    //test(data);
   // matrix_transpose_cpu_slab(data);
    //transpose_y_z_keeping_x_fixed(matrix);
    //transpose_wrt_x(data);
    //transpose_wrt_x_3d(data);
    //matrix_dim_change_cpu(data);
    //Matrix_transpose_cpu(data);
    //Matrix_transpose_gpu(matrix);
    return 0;
}
