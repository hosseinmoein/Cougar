<!--
Copyright (c) 2023-2028, Hossein Moein
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
* Redistributions of source code must retain the above copyright
notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright
notice, this list of conditions and the following disclaimer in the
documentation and/or other materials provided with the distribution.
* Neither the name of Hossein Moein and/or the Cougar nor the
names of its contributors may be used to endorse or promote products
derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL Hossein Moein BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-->
![GitHub](https://img.shields.io/github/license/hosseinmoein/DataFrame.svg?color=red&style=popout)
[![C++20](https://img.shields.io/badge/C%2B%2B-20-blue.svg)](https://isocpp.org/std/the-standard )
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/hosseinmoein/DataFrame/graphs/commit-activity)

<img src="docs/Cougar.png" alt="Allocator Cougar" width="400" longdesc="https://htmlpreview.github.io/?https://github.com/hosseinmoein/Cougar/blob/master/README.md"/>

This repo includes several STL conformant allocators. There are two categories of allocators here:
1. Stack or Static based fixed size allocators. In this category you pre-allocate a fixed size of memory block either on the stack or statically. So you can have STL containers that are based on stack memory, for example. One of the side effects of these allocators is to overcome deficiencies in containers like <I>maps</I> and <I>lists</I> where their memory by default is not cache-friendly.
2. Custom Aligned allocator. This allocator allows you to allocate memory on a custom boundary. This way you can take advantage of SIMD instructions and techniques. 

Please see the [tester file](test/allocator_tester.cc) for code samples.

This is the complete list of allocators in this repo:

```cpp
// An allocator that allows you to allocate memory for type T on boundary AS.
// The default boundary is system default for type T.
template<typename T, std::size_t AS = 0>
AlignedAllocator
```
```cpp
// This allocator pre-allocates memory for MAX_SIZE * sizeof(T) bytes statically.
// It uses best-fit algorithm to find space. Best-fit is a bit slower,
// but it causes considerably less fragmentations
template<typename T, std::size_t MAX_SIZE>
StaticBestFitAllocator
```
```cpp
// This allocator pre-allocates memory for MAX_SIZE * sizeof(T) bytes on the stack.
// It uses best-fit algorithm to find space. Best-fit is a bit slower,
// but it causes considerably less fragmentations
template<typename T, std::size_t MAX_SIZE>
StackBestFitAllocator
```
```cpp
// This allocator pre-allocates memory for MAX_SIZE * sizeof(T) bytes statically.
// It uses first-fit algorithm to find space. First-fit is faster,
// but it causes more fragmentations
template<typename T, std::size_t MAX_SIZE>
StaticFirstFitAllocator
```
```cpp
// This allocator pre-allocates memory for MAX_SIZE * sizeof(T) bytes on the stack.
// It uses first-fit algorithm to find space. First-fit is faster,
// but it causes more fragmentations
template<typename T, std::size_t MAX_SIZE>
StackFirstFitAllocator
```
