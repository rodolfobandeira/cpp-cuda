/*
sudo apt install cuda-nvidia-toolkit
nvcc hello.cu -o hello
*/

#include <iostream>
#include <cuda_runtime.h>

__global__ void helloCUDA()
{
    printf("Hello CUDA!\n");
}

int main()
{
    // Launch the kernel
    helloCUDA<<<1,1>>>();
    cudaDeviceSynchronize();

    // Print a message to indicate completion
    std::cout << "Kernel executed successfully!\n";

    return 0;
}

