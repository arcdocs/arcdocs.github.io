# cuDNN

The NVIDIA CUDA&reg; Deep Neural Network library (cuDNN) is a GPU-accelerated library of primitives for deep neural networks. cuDNN provides highly tuned implementations for standard routines such as forward and backward convolution, pooling, normalization, and activation layers.



Read more about cuDNN on their [website](https://developer.nvidia.com/cudnn).





## Licensing

The cuDNN license is available to read on the [NVIDIA website](https://docs.nvidia.com/deeplearning/cudnn/sla/index.html)



## The cuDNN module on the HPC

The cuDNN module can be loaded into your environment with the following command:

```bash
$ module add cudnn
```

The cuDNN module is available on ARC4:

```{list-table}
:header-rows: 1
:widths: 10 20 10


* - System
  - Version
  - Command

* - ARC4
  - CUDNN 7.6.5
  - `module add cudnn/7.6.5`

```
