#include <iostream>
#include <cuda_runtime.h>

#define N 1000000

__global__ void binary_search(int* array, int key, int* result)
{
    int left = 0;
    int right = N - 1;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (array[mid] == key) {
            *result = mid;
            return;
        } else if (array[mid] < key) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    *result = -1;
}

int main()
{
    int array[N];
    for (int i = 0; i < N; i++) {
        array[i] = i;
    }

    int key = 1234;
    int result = -1;

    int* d_array;
    int* d_result;

    cudaMalloc((void**)&d_array, N * sizeof(int));
    cudaMalloc((void**)&d_result, sizeof(int));

    cudaMemcpy(d_array, array, N * sizeof(int), cudaMemcpyHostToDevice);

    binary_search<<<1,1>>>(d_array, key, d_result);

    cudaMemcpy(&result, d_result, sizeof(int), cudaMemcpyDeviceToHost);

    cudaFree(d_array);
    cudaFree(d_result);

    if (result == -1) {
        std::cout << "Element not found" << std::endl;
    } else {
        std::cout << "Element found at index " << result << std::endl;
    }

    return 0;
}

