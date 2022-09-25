#include<iostream>
#include<cuda.h>
#include<cuda_runtime.h>
#include<device_launch_parameters.h>

__global__ void grading(float* number_device, char* grades)
{
    __shared__ int pass_count,failcount; 
    if(number_device[threadIdx.x]>50)
    {
        grades[threadIdx.x] = 'P';
        atomicAdd(&pass_count,1);
    }
    else
    {
        grades[threadIdx.x] = 'F';
        atomicAdd(&failcount,1);
    }
    __syncthreads();
    if(threadIdx.x ==0)
    {
        printf("\n Therefore on gpu pass count = %d , fail count = %d",pass_count,failcount);
    }

}

int main()
{
    int a,pass_count_cpu{0},fail_count_cpu{0};
    std::cout<<"\n Enter The number of students ";
    std::cin>>a;
    
    float* number = new float[a], * number_device;
    char* grades;
    for (int i = 0; i < a; i++)
    {
        number[i] = rand()%100;
        if(number[i]>50)
        {
            pass_count_cpu++;
        }
        else{
            fail_count_cpu++;
        }

    }
    std::cout<<"\n therefore on cpu passcount = "<<pass_count_cpu<<" , failcount =  "<<fail_count_cpu;
    cudaMalloc(&grades,sizeof(char)*a);
    cudaMalloc(&number_device,sizeof(float)*a);
    cudaMemcpy(number_device,number,sizeof(float)*a,cudaMemcpyHostToDevice);

    grading<<<1,a>>>(number_device,grades);

    return 0;
}