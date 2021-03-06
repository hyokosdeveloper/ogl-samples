#version 330 core
#extension GL_ARB_shading_language_420pack : require

#define POSITION		0
#define COLOR			3
#define TRANSFORM0		1

#define COLOR_COUNT		10

precision highp float;
precision highp int;
layout(std140, column_major) uniform;

layout(binding = TRANSFORM0) uniform transform
{
	mat4 MVP;
} Transform;

layout(location = 0) in vec2 Position;
layout(location = 1) in vec4 Color[COLOR_COUNT];

out gl_PerVertex
{
	vec4 gl_Position;
};

out block
{
	vec4 Color;
} Out;

void main()
{
/*
	Out.Color = vec4(0.0);
	for(int i = 0; i < COLOR_COUNT; ++i)
		Out.Color += Color[i];
*/
	vec4 Temp = vec4(0.0);
	for(int i = 0; i < COLOR_COUNT; ++i)
		Temp += Color[i];
	Out.Color = Temp;//vec4(Temp, 1.0);

	gl_Position = Transform.MVP * vec4(Position, 0, 1);
}
