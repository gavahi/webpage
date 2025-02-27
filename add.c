#include "stdio.h"
#include "stdlib.h"
#include <sys/time.h>
#include <time.h>
#define N 10000000

/* void add( int *a, int *b, int *c ) {
	int tid = 0;  // this is CPU zero, so we start at zero
	while (tid < N) {
		c[tid] = a[tid] + b[tid];
		tid += 1;  // we have one CPU, so we increment by one
	}
} */
int main( void ) {
	
	int *a, *b, *c;
	int tid = 0;
	struct timeval t1,t2;
	
	a = (int*) malloc (N * sizeof(int));
	b = (int*) malloc (N * sizeof(int));
	c = (int*) malloc (N * sizeof(int));
	
	// fill the arrays 'a' and 'b' on the CPU
	int i;
	for (i=0; i<N; i++) {
		a[i] = -i;
		b[i] = i * i;
	}
	
	//add( a, b, c );
	
	gettimeofday(&t1,NULL);
	
	while (tid < N) {
		c[tid] = a[tid] + b[tid];
		tid += 1;  // we have one CPU, so we increment by one
	}
	
	gettimeofday(&t2,NULL);	
	double elapsed_time = ((t2.tv_sec - t1.tv_sec)*1000.0) + ((t2.tv_usec - t1.tv_usec)/1000.0);
	printf("\n\n\tElapsed Time  = %.5f ms\n\n",elapsed_time);
	
	free( a );
	free( b );
	free( c );
	
	return 0; 
}