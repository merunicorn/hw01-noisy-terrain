#version 300 es
precision highp float;

uniform vec2 u_PlanePos; // Our location in the virtual world displayed by the plane

vec3 bg_Col = vec3(88.0 / 255.0, 91.0 / 255.0, 196.0 / 255.0);
vec3 sand_Col = vec3(255.0 / 255.0, 229.0 / 255.0, 99.0 / 255.0);
vec3 blue_Wor = vec3(67.0 / 255.0, 153.0 / 255.0, 219.0 / 255.0);
vec3 white_Wor = vec3(255.0 / 255.0, 255.0 / 255.0, 255.0 / 255.0);

//[[0.500 0.500 0.500] [0.500 0.500 0.500] [0.500 0.500 0.298] [1.448 0.588 -0.182]]
//sunlight cosine pallete
/*
vec3 sun_a = vec3(0.5, 0.5, 0.5);
vec3 sun_b = sun_a;
vec3 sun_c = vec3(0.5, 0.5, 0.298);
vec3 sun_d = vec3(1.448, 0.588, -0.182);*/

//Cosine Color Pallete (Adam's code)
/*
vec3 cosinePalette(float t) {
    return clamp(sun_a + sun_b * cos(2.0 * 3.14159 * (sun_c * t + sun_d)), 0.0, 1.0);
}*/

in vec3 fs_Pos;
in vec4 fs_Nor;
in vec4 fs_Col;

in float fs_Sine;
in float fs_FBM;
//in float fs_Worley;

out vec4 out_Col; // This is the final output color that you will see on your
                  // screen for the pixel that is currently being processed.

void main()
{
    float t = clamp(smoothstep(40.0, 50.0, length(fs_Pos)), 0.0, 1.0); // Distance fog
    //float t = clamp(pow(fs_Pos.x,2.0), 0.0, 1.0); //x^2 graph

    //vec3 col_sunlight = cosinePalette(fs_Worley);

    //mix: 2 vec3s and a float
    vec3 col_sandwater = vec3(mix(bg_Col, sand_Col, 0.4));
    vec4 col_step = vec4(mix(col_sandwater, bg_Col, t),1.0);
    vec3 col_fbm = vec3(mix(sand_Col, vec3(0.25 * (fs_FBM + 1.0)), 0.5));
    vec4 col_step2 = vec4(mix(col_fbm, bg_Col, t), 1.0);
    
    //vec3 col_step = vec3(mix(bg_Col, sand_Col, vec3(0.25 * (fs_FBM + 1.0))));

    out_Col = col_step2;
    //out_Col = vec4(col_sunlight,1.0);

    //out_Col = vec4(mix(col_step, vec3(0.25 * (fs_FBM + 1.0)), t), 1.0);
    //out_Col = vec4(mix((vec3(0.50,0.20,0.30) + vec3(0.25 * (fs_FBM + 1.0))), 
    //                   vec3(88.0 / 255.0, 91.0 / 255.0, 196.0 / 255.0), t), 1.0);
                       //t = distance fog blend
                       //second value = equivalent color to sky
    //out_Col = vec4(mix(vec3(0.5 * (fs_Sine + 1.0)), 
    //                   vec3(88.0 / 255.0, 91.0 / 255.0, 196.0 / 255.0), t), 1.0);
    //out_Col = vec4(mix(vec3(0.5 * (fs_Sine + 1.0)), vec3(164.0 / 255.0, 233.0 / 255.0, 1.0), t), 1.0);
}
