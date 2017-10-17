#version 430 core

layout (local_size_x = 32, local_size_y = 32) in;

layout (binding = 0, rgba8) uniform writeonly image2D defferedSceneSampler;

layout (binding = 1, rgba8) uniform readonly image2D albedoSceneSampler;

layout (binding = 2, rgba32f) uniform readonly image2D worldPositionSampler;

layout (binding = 3, rgba32f) uniform readonly image2D normalSampler;

layout (binding = 4, rgba8) uniform readonly image2D specularEmissionSampler;

layout (std140, row_major) uniform Camera{
	vec3 eyePosition;
	mat4 m_View;
	mat4 m_ViewProjection;
	vec4 frustumPlanes[6];
};

layout (std140) uniform DirectionalLight{
	vec3 direction;
	float intensity;
	vec3 ambient;
	vec3 color;
} directional_light;

layout (std140, row_major) uniform LightViewProjections{
	mat4 m_lightViewProjection[6];
	float splitRange[6];
};

float diffuse(vec3 direction, vec3 normal, float intensity)
{
	return max(0.1, dot(normal, -direction) * intensity);
}

void main(void){

	ivec2 computeCoord = ivec2(gl_GlobalInvocationID.x, gl_GlobalInvocationID.y);
	
	vec3 albedo = imageLoad(albedoSceneSampler, computeCoord).rgb; 
	vec3 position = imageLoad(worldPositionSampler, computeCoord).rgb;
	vec3 normal = imageLoad(normalSampler, computeCoord).rgb;
	vec2 specular_emission = imageLoad(specularEmissionSampler, computeCoord).rg;
	
	float dist = length(eyePosition - position);
	
	vec3 finalColor = vec3(1,0,0) * dist;
		
	imageStore(defferedSceneSampler, computeCoord, vec4(finalColor, 1.0));
}