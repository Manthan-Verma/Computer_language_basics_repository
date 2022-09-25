#include <iostream>
#include <cuda.h>
#include<cuda_runtime.h>
#include<device_launch_parameters.h>

// Using constexpr
/*constexpr int m{ 99 };                                              // ---> availaible in the main memory so its availaible to both gpu and cpu 

__global__ void show()
{
    printf("\n data is = %d ", m);
}

int main()
{
    show << <1, 1 >> > ();
    cudaDeviceSynchronize();

    return 0;

}*/


// For Normal data 
__constant__ int m;
__global__ void show()
{
    printf("\n data is = %d " , m);
}


int main()
{
    int a{10};
    cudaMemcpyToSymbol( m, &a , sizeof(int));
    show<<<1,1>>>();
    cudaDeviceSynchronize();
    a = 90;
    cudaMemcpyToSymbol( m, &a , sizeof(int));
    show<<<1,1>>>();
    cudaDeviceSynchronize();
    return 0;

}



// For Array 
/*
__constant__ int m[10];

__global__ void show()
{
    printf("\n data is = %d " , m[2]);
}

int main()
{
    int* a = new int[10]{0,1,2,3,4,5,6,7,8,9};
    cudaMemcpyToSymbol( m, a , sizeof(int)*10);
    show<<<1,1>>>();
    cudaDeviceSynchronize();

    return 0;

}*/