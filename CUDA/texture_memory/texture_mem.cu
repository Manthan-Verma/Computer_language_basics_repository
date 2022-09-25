#include"texture_mem.cuh"

__global__ void t(cudaArray * array)
{
    printf("\n data = %f ", tex2D(tex, 0, 0));
    printf("\n data = %f ", tex2D(tex, 0, 1)); // From the output here you will notice that GPU's has coloum major approch rather than row major
    printf("\n data = %f ", tex2D(tex, 1, 0));
    printf("\n data = %f ", tex2D(tex, 1, 1));

    printf("\n cudarray -> %f",array);
}
int main()
{
    
    cudaChannelFormatDesc desc = cudaCreateChannelDesc<float>();
    float *cuarray;
    float hostarray[2][2]{0, 1, 2, 3};              //  Can make this a pointer array also, both works .
    std::cout << "\n hostarray -> " << hostarray[0][1];
    cudaArray *array;

    if (cudaMallocArray(&array, &desc, 2, 2) != cudaSuccess)
    {
        std::cout << "\n Failed to initalize cuarray";
    }

    if (cudaMemcpyToArray(array, 0, 0, hostarray, sizeof(float) * Nx * Ny, cudaMemcpyHostToDevice) != cudaSuccess)
    {
        std::cout << "\n failed to copy host to gpu ";
    }

    cudaBindTextureToArray(tex, array);

    t<<<1, 1>>>(array);
    cudaDeviceSynchronize();
    return 0;
}

//    1D USAGE OF TEXTURE MEMORY
/*
__global__ void t()
{
    printf("\n data = %f ",tex1Dfetch(tex,2));
}
int main()
{
    float* cuarray;
    float* hostarray = new float[]{0,1,2,3};
    
    if(cudaMalloc(&cuarray,sizeof(float)*Nx*Ny) != cudaSuccess)
    {
        std::cout<<"\n Failed to initalize cuarray";
    }

    if(cudaMemcpy(cuarray,hostarray,sizeof(float)*Nx*Ny,cudaMemcpyHostToDevice) != cudaSuccess)
    {
        std::cout<<"\n failed to copy host to gpu ";
    }

    cudaChannelFormatDesc desc = cudaCreateChannelDesc<float>();
    cudaBindTexture(NULL, tex , cuarray,sizeof(float)*Nx*Ny);

    t<<<1,1>>>();
    cudaDeviceSynchronize();

    return 0;
}*/