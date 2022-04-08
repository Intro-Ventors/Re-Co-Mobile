#pragma once

#include <vector>
#include <string>
#include <cstdint>

using ShaderCode = std::vector<uint32_t>;

inline ShaderCode ToShaderCode(const std::string_view &string)
{
	ShaderCode code(string.size());
	std::copy(string.begin(), string.end(), reinterpret_cast<char *>(code.data()));

	return code;
}

inline ShaderCode ToShaderCode(const std::vector<uint8_t> &bytes)
{
	ShaderCode code(bytes.size());
	std::copy(bytes.begin(), bytes.end(), reinterpret_cast<char *>(code.data()));

	return code;
}

template <uint64_t Size>
inline ShaderCode FromRawArrayToShaderCode(const unsigned char (&bytes)[Size])
{
	ShaderCode code(Size);
	std::copy(bytes, bytes + Size, reinterpret_cast<unsigned char *>(code.data()));

	return code;
}