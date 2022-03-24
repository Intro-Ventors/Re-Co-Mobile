"""
SPIR-V to header script.
This scripts can be used to convert the SPIR-V binary data to a header file, where a vector will contain all the binary data.

How to use:
> python spirv_to_header.py shader_source.spv output_header.h variable_name
"""

import sys

if len(sys.argv) != 4:
	print("Usage: python spirv_to_header.py shader_source.spv output_header.h variable_name")
	exit()

shader_source = sys.argv[1]
output_header = sys.argv[2]
variable_name = sys.argv[3]

spirv_data = ""

with open(shader_source, 'rb') as source, open(output_header, 'w+') as header:
    shader_source = source.read()

    for byte in shader_source:
        spirv_data += str(byte) + ", "

    header.write("#pragma once\n")
    header.write("\n")
    header.write("#include <cstdint>\n")
    header.write("\n")
    header.write(f"constexpr uint8_t {variable_name}[] = \n")
    header.write("{\n")
    header.write(spirv_data)
    header.write("\n};")
