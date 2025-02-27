#include <stdio.h>
#define N 1024 

__global__ void add( /* arguments */ ) {
	// addressing data by thread index:
	// use blockIdx.x , blockDim.x ,threadIdx.x variables

	
	// add operation
	
}

int main( void ) {

	// initiate variables for CPU: use pointer type


	
	// initiate variables for GPU: use pointer type



	// allocate the memory on the CPU:
	// <var> = (<type> *) malloc (<size> * sizeof(<type>));


	
	// allocate the memory on the GPU
	// cudaMalloc( &<var>  ,  <size> * sizeof( <type> ) ) ;


	
	// fill the input arrays on the CPU
	// use "for_loop" command	
	for (int i = 0 ;  i < N ;  i++ ) {
		a[i] = i ;
		b[i] = i * i ;	}
		
	// copy the input arrays to the GPU
	// cudaMemcpy( <dest_var> , <source_var> , <size> * sizeof( <type> ) , <direction> );
	
	

	// call kernel: 128 thread in each block
	// <kernel_name> <<< <# block> , <# thread> >>> ( <Argoments> );

	
	
	// copy the result array back from the GPU to the CPU
	// cudaMemcpy( <dest_var> , <source_var> , <size> * sizeof( <type> ) , <direction> );
	

	
	
	// free the memory allocated on the CPU
	// free(<var>);

	
	// free the memory allocated on the GPU
	// cudaFree(<var>);

	
	return 0; 
}
