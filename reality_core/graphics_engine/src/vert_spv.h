#pragma once

#include <vector>
#include <cstdint>

inline std::vector<uint8_t> vert_spv = 
{
3, 2, 35, 7, 0, 0, 1, 0, 10, 0, 8, 0, 35, 0, 0, 0, 0, 0, 0, 0, 17, 0, 2, 0, 1, 0, 0, 0, 11, 0, 6, 0, 1, 0, 0, 0, 71, 76, 83, 76, 46, 115, 116, 100, 46, 52, 53, 48, 0, 0, 0, 0, 14, 0, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 15, 0, 10, 0, 0, 0, 0, 0, 4, 0, 0, 0, 109, 97, 105, 110, 0, 0, 0, 0, 9, 0, 0, 0, 11, 0, 0, 0, 19, 0, 0, 0, 24, 0, 0, 0, 34, 0, 0, 0, 3, 0, 3, 0, 2, 0, 0, 0, 194, 1, 0, 0, 4, 0, 9, 0, 71, 76, 95, 65, 82, 66, 95, 115, 101, 112, 97, 114, 97, 116, 101, 95, 115, 104, 97, 100, 101, 114, 95, 111, 98, 106, 101, 99, 116, 115, 0, 0, 5, 0, 4, 0, 4, 0, 0, 0, 109, 97, 105, 110, 0, 0, 0, 0, 5, 0, 5, 0, 9, 0, 0, 0, 111, 117, 116, 84, 101, 120, 116, 117, 114, 101, 0, 0, 5, 0, 5, 0, 11, 0, 0, 0, 105, 110, 84, 101, 120, 116, 117, 114, 101, 0, 0, 0, 5, 0, 6, 0, 17, 0, 0, 0, 103, 108, 95, 80, 101, 114, 86, 101, 114, 116, 101, 120, 0, 0, 0, 0, 6, 0, 6, 0, 17, 0, 0, 0, 0, 0, 0, 0, 103, 108, 95, 80, 111, 115, 105, 116, 105, 111, 110, 0, 6, 0, 7, 0, 17, 0, 0, 0, 1, 0, 0, 0, 103, 108, 95, 80, 111, 105, 110, 116, 83, 105, 122, 101, 0, 0, 0, 0, 6, 0, 7, 0, 17, 0, 0, 0, 2, 0, 0, 0, 103, 108, 95, 67, 108, 105, 112, 68, 105, 115, 116, 97, 110, 99, 101, 0, 6, 0, 7, 0, 17, 0, 0, 0, 3, 0, 0, 0, 103, 108, 95, 67, 117, 108, 108, 68, 105, 115, 116, 97, 110, 99, 101, 0, 5, 0, 3, 0, 19, 0, 0, 0, 0, 0, 0, 0, 5, 0, 4, 0, 24, 0, 0, 0, 105, 110, 80, 111, 115, 0, 0, 0, 5, 0, 4, 0, 34, 0, 0, 0, 105, 110, 67, 111, 108, 111, 114, 0, 71, 0, 4, 0, 9, 0, 0, 0, 30, 0, 0, 0, 0, 0, 0, 0, 71, 0, 4, 0, 11, 0, 0, 0, 30, 0, 0, 0, 2, 0, 0, 0, 72, 0, 5, 0, 17, 0, 0, 0, 0, 0, 0, 0, 11, 0, 0, 0, 0, 0, 0, 0, 72, 0, 5, 0, 17, 0, 0, 0, 1, 0, 0, 0, 11, 0, 0, 0, 1, 0, 0, 0, 72, 0, 5, 0, 17, 0, 0, 0, 2, 0, 0, 0, 11, 0, 0, 0, 3, 0, 0, 0, 72, 0, 5, 0, 17, 0, 0, 0, 3, 0, 0, 0, 11, 0, 0, 0, 4, 0, 0, 0, 71, 0, 3, 0, 17, 0, 0, 0, 2, 0, 0, 0, 71, 0, 4, 0, 24, 0, 0, 0, 30, 0, 0, 0, 0, 0, 0, 0, 71, 0, 4, 0, 34, 0, 0, 0, 30, 0, 0, 0, 1, 0, 0, 0, 19, 0, 2, 0, 2, 0, 0, 0, 33, 0, 3, 0, 3, 0, 0, 0, 2, 0, 0, 0, 22, 0, 3, 0, 6, 0, 0, 0, 32, 0, 0, 0, 23, 0, 4, 0, 7, 0, 0, 0, 6, 0, 0, 0, 2, 0, 0, 0, 32, 0, 4, 0, 8, 0, 0, 0, 3, 0, 0, 0, 7, 0, 0, 0, 59, 0, 4, 0, 8, 0, 0, 0, 9, 0, 0, 0, 3, 0, 0, 0, 32, 0, 4, 0, 10, 0, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 59, 0, 4, 0, 10, 0, 0, 0, 11, 0, 0, 0, 1, 0, 0, 0, 23, 0, 4, 0, 13, 0, 0, 0, 6, 0, 0, 0, 4, 0, 0, 0, 21, 0, 4, 0, 14, 0, 0, 0, 32, 0, 0, 0, 0, 0, 0, 0, 43, 0, 4, 0, 14, 0, 0, 0, 15, 0, 0, 0, 1, 0, 0, 0, 28, 0, 4, 0, 16, 0, 0, 0, 6, 0, 0, 0, 15, 0, 0, 0, 30, 0, 6, 0, 17, 0, 0, 0, 13, 0, 0, 0, 6, 0, 0, 0, 16, 0, 0, 0, 16, 0, 0, 0, 32, 0, 4, 0, 18, 0, 0, 0, 3, 0, 0, 0, 17, 0, 0, 0, 59, 0, 4, 0, 18, 0, 0, 0, 19, 0, 0, 0, 3, 0, 0, 0, 21, 0, 4, 0, 20, 0, 0, 0, 32, 0, 0, 0, 1, 0, 0, 0, 43, 0, 4, 0, 20, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 0, 23, 0, 4, 0, 22, 0, 0, 0, 6, 0, 0, 0, 3, 0, 0, 0, 32, 0, 4, 0, 23, 0, 0, 0, 1, 0, 0, 0, 22, 0, 0, 0, 59, 0, 4, 0, 23, 0, 0, 0, 24, 0, 0, 0, 1, 0, 0, 0, 43, 0, 4, 0, 6, 0, 0, 0, 26, 0, 0, 0, 0, 0, 128, 63, 32, 0, 4, 0, 31, 0, 0, 0, 3, 0, 0, 0, 13, 0, 0, 0, 32, 0, 4, 0, 33, 0, 0, 0, 1, 0, 0, 0, 13, 0, 0, 0, 59, 0, 4, 0, 33, 0, 0, 0, 34, 0, 0, 0, 1, 0, 0, 0, 54, 0, 5, 0, 2, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 248, 0, 2, 0, 5, 0, 0, 0, 61, 0, 4, 0, 7, 0, 0, 0, 12, 0, 0, 0, 11, 0, 0, 0, 62, 0, 3, 0, 9, 0, 0, 0, 12, 0, 0, 0, 61, 0, 4, 0, 22, 0, 0, 0, 25, 0, 0, 0, 24, 0, 0, 0, 81, 0, 5, 0, 6, 0, 0, 0, 27, 0, 0, 0, 25, 0, 0, 0, 0, 0, 0, 0, 81, 0, 5, 0, 6, 0, 0, 0, 28, 0, 0, 0, 25, 0, 0, 0, 1, 0, 0, 0, 81, 0, 5, 0, 6, 0, 0, 0, 29, 0, 0, 0, 25, 0, 0, 0, 2, 0, 0, 0, 80, 0, 7, 0, 13, 0, 0, 0, 30, 0, 0, 0, 27, 0, 0, 0, 28, 0, 0, 0, 29, 0, 0, 0, 26, 0, 0, 0, 65, 0, 5, 0, 31, 0, 0, 0, 32, 0, 0, 0, 19, 0, 0, 0, 21, 0, 0, 0, 62, 0, 3, 0, 32, 0, 0, 0, 30, 0, 0, 0, 253, 0, 1, 0, 56, 0, 1, 0, 
};