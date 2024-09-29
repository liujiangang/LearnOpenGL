#version 330 core
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 aNormal;
layout (location = 2) in vec2 aTexCoords;

out vec2 TexCoords;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

uniform mat4 model_rear_wheel;
uniform mat4 model_front_wheel;
uniform int mesh_type;
#define MESH_TYPE_REAR_WHEEL 1
#define MESH_TYPE_FRONT_WHEEL 2
#define MESH_TYPE_CAR_BODY 0

out vec3 FragPos;
out vec3 Normal;

void main()
{
    TexCoords = aTexCoords;
    if(mesh_type == MESH_TYPE_REAR_WHEEL || mesh_type == MESH_TYPE_FRONT_WHEEL) {
        if(aPos.x < 0.0f) {
            FragPos = vec3(model_rear_wheel * vec4(aPos, 1.0));
            Normal = mat3(transpose(inverse(model_rear_wheel))) * aNormal;
            gl_Position = projection * view * model_rear_wheel * vec4(aPos, 1.0);
        } else {
            FragPos = vec3(model_front_wheel * vec4(aPos, 1.0));
            Normal = mat3(transpose(inverse(model_front_wheel))) * aNormal;
            gl_Position = projection * view * model_front_wheel * vec4(aPos, 1.0);
        }
    } else {
        FragPos = vec3(model * vec4(aPos, 1.0));
        Normal = mat3(transpose(inverse(model))) * aNormal;
        gl_Position = projection * view * model * vec4(aPos, 1.0);
    }
}
