#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(location = 0) in vec3 inPos; 
layout(location = 1) in vec4 inColor;
layout(location = 2) in vec2 inTexture;

layout(location = 0) out vec2 outTexture;

layout(set = 0, binding = 0) uniform Camera {
    mat4 view;
    mat4 proj;
} cam;

layout(set = 0, binding = 1) uniform Model {
    mat4 model;
} model;

void main() {
	outTexture = inTexture;
    gl_Position = cam.proj * cam.view * model.model * vec4(inPos, 1.0f);
}