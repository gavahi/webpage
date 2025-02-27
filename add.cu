#include "iostream"
#include "stdio.h"
#include <time.h>
#include <sys/time.h>

#define N 10000000

__global__ void add( int *a, int *b, int *c ) {
	int tid = blockIdx.x;  // handle the data at this index
	if (tid < N)
		c[tid] = a[tid] + b[tid]; 
}

int main( void ) {
	int *a, *b, *c;
	int *dev_a, *dev_b, *dev_c;
	//struct timeval t1,t2;
	
	cudaEvent_t start, stop;
	
	  cudaEventCreate( &start ) ;
	  cudaEventCreate( &stop ) ;
	  
	
	
/* 	malloc( (void**)&a, N * sizeof(int) ) ;
	malloc( (void**)&b, N * sizeof(int) ) ;
	malloc( (void**)&c, N * sizeof(int) ) ; */
	
	a = (int*) malloc (N * sizeof(int));
	b = (int*) malloc (N * sizeof(int));
	c = (int*) malloc (N * sizeof(int));
	
	// allocate the memory on the GPU
	cudaMalloc( (void**)&dev_a, N * sizeof(int) ) ;
	cudaMalloc( (void**)&dev_b, N * sizeof(int) );
	cudaMalloc( (void**)&dev_c, N * sizeof(int) );
	
	// fill the arrays 'a' and 'b' on the CPU
	for (int i=0; i<N; i++) {
		a[i] = i;
		b[i] = i * i;
	}
	
	// copy the arrays 'a' and 'b' to the GPU
	cudaMemcpy( dev_a, a, N * sizeof(int),cudaMemcpyHostToDevice );
	cudaMemcpy( dev_b, b, N * sizeof(int),cudaMemcpyHostToDevice );
	
	//gettimeofday(&t1,NULL);
	
	cudaEventRecord( start, 0 ) ;
	
	add<<<N/128,128>>>( dev_a, dev_b, dev_c );
	cudaMemcpy( c, dev_c, N * sizeof(int),cudaMemcpyDeviceToHost );
	
	cudaEventRecord( stop, 0 ) ;
	cudaEventSynchronize( stop ) ;
	float  elapsedTime;
	cudaEventElapsedTime( &elapsedTime, start, stop ) ;
	printf( "\n\n\tTime to generate: %3.1f ms\n\n", elapsedTime );
	
	
	//gettimeofday(&t2,NULL);	
	//double elapsed_time = ((t2.tv_sec - t1.tv_sec)*1000.0) + ((t2.tv_usec - t1.tv_usec)/1000.0);
	//printf("\n\n\tElapsed Time  = %.5f ms\n\n",elapsed_time);
	
	// copy the array 'c' back from the GPU to the CPU
	
	
	free( a );
	free( b );
	free( c );
	
	// free the memory allocated on the GPU
	cudaFree( dev_a );
	cudaFree( dev_b );
	cudaFree( dev_c );
	
	return 0; 
}
