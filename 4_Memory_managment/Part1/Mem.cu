#include"mem.cuh"


//                IN C++
/*
int main()
{
	float* var, * var2, * var3;
	var = new float[Nx * Ny * Nz]{};				// Allocates the memory in C++ and empty {} initialize it to ZERO 
	var2 = new float{};								// Allocates only 1 memory address

	delete var2;									// Frees the memory as free in c 
	var2 = nullptr;										// ALWAYS DO THIS AFTER DELETE 

	delete[] var;										// deletes the pointer array 
	var = nullptr;
}
*/



//    IN C

/*
int main()
{
	float* var, * var2;
	// INITIALIZATIONS 
	var = (float*)malloc(sizeof(float) * Nx * Ny * Nz);					// Assigning memory using malloc (not initalization
	var2 = (float*)calloc(Nx * Ny * Nz, sizeof(float));					// Using calloc ---> allocates and initialise to 0 
	var2 = (float*)realloc(var2, sizeof(float)*Nx * Ny);				// reallocates the memory for a pointer as shown
	//var2 = (float*)realloc()

	
	// FREEING THE MEMORY 
	free(var);								// Free is used to free the memory 
	var = nullptr;							// Always do this after freeing the memory or elese it will be a dangling pointer 

	free(var2);
	var2 = nullptr;
}*/



//							2D POINTERS    ARRAYS
/*
int main()
{
	int* p1, * p2, ** p;
	p1 = new int[10]{ 1,2,3,4,5,6,7,8,9,10 };
	p2 = new int[10]{ 11,12,13,14,15,16,17,18,19,20 };

	p = new int*[2]{ p1,p2 };
	for (int i = 0; i < 10; i++)
	{
		std::cout << "\n p1[" << i + 1 << "] = " << p[0][i] << "	, p2[" << i + 11 << "] = " << p[1][i];
	}
	return 0;
}*/