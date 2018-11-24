# -*- mode: snippet -*-
# name: ctmplt
# key: ctmplt
# --
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

#define FOR(i,b,e) for(i=(b);i<(e);++i)
#define FORQ(i,b,e) for(i=(b);i<=(e);++i)
#define FORD(i,b,e) for(i=(b)-1;i>=(e);--i)
#define REP(x, n) for(x = 0; x < (n); ++x)

#define mat(n,i,j) A[(i)*(n)+(j)]


void PrintMatrix(double *x, int n);
void PrintVector(double *x, int n);

void PrintMatrix(double *x, int n){
  int i,j;
  FOR(i,0,n){
    FOR(j,0,n){
      printf("%15f",x[n*i+j]);
    }
    printf("\n");
  }
} 

void PrintVector(double *x, int n){
  int i;
  FOR(i,0,n){
    printf("%15f\n",x[i]);
  }
}

int main(void){

  return 0;
}