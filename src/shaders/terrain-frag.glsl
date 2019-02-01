#version 300 es
precision highp float;

uniform vec2 u_PlanePos; // Our location in the virtual world displayed by the plane

vec3 bg_Col = vec3(88.0 / 255.0, 91.0 / 255.0, 196.0 / 255.0);
vec3 sand_Col = vec3(255.0 / 255.0, 229.0 / 255.0, 99.0 / 255.0);

//[[0.718 0.698 0.548] [-0.212 0.498 0.500] [0.328 0.438 0.418] [-0.262 0.348 0.478]]
//rock cosine palette
vec3 rock_a = vec3(0.718, 0.698, 0.548);
vec3 rock_b = vec3(-0.212, 0.498, 0.500);
vec3 rock_c = vec3(0.328, 0.438, 0.418);
vec3 rock_d = vec3(-0.262, 0.348, 0.478);

//[[0.500 0.500 0.500] [0.500 0.500 0.500] [0.500 0.500 0.298] [1.448 0.588 -0.182]]
//sunlight cosine pallete
vec3 sun_a = vec3(0.5, 0.5, 0.5);
vec3 sun_b = vec3(0.5, 0.5, 0.5);
vec3 sun_c = vec3(0.5, 0.5, 0.298);
vec3 sun_d = vec3(1.448, 0.588, -0.182);

//Cosine Color Pallete (Adam's code)
vec3 cosinePalette(float t, float i) {
    if (i == 1.0) {
        return clamp(sun_a + sun_b * cos(2.0 * 3.14159 * 
        (sun_c * t + sun_d)), 0.0, 1.0);
    }
    else {
        return clamp(rock_a + rock_b * cos(2.0 * 3.14159 * 
        (rock_c * t + rock_d)), 0.0, 1.0);
    }
    
}

in vec3 fs_Pos;
in vec4 fs_Nor;
in vec4 fs_Col;

in float fs_Sine;
in float fs_FBM;
in float fs_Worley;
in float fs_Rock;

out vec4 out_Col; // This is the final output color that you will see on your
                  // screen for the pixel that is currently being processed.

void main()
{
    float t = clamp(smoothstep(40.0, 50.0, length(fs_Pos)), 0.0, 1.0); // Distance fog
    
    vec3 col_fbm = vec3(mix(sand_Col, vec3(0.25 * (fs_FBM + 1.0)), 0.5));
    vec4 col_step = vec4(mix(col_fbm, bg_Col, t), 1.0);

    vec3 col_sunlight = cosinePalette((fs_FBM/1.5) * fs_Worley, 1.0);
    vec4 col_step2 = vec4(mix(col_sunlight * 1.7, bg_Col, t), 1.0);

    vec3 col_rock = 0.5 * cosinePalette((fs_FBM/1.5) * pow(fs_Worley,0.2), 2.0);
    vec4 col_step3 = vec4(mix(col_rock, bg_Col, t), 1.0);
    if (fs_Rock < 0.2) {
        col_step3 = vec4(mix(vec3(col_step), bg_Col, t), 1.0);
    }

    vec4 col_sand = vec4(mix(col_step, col_step2, 0.2));
    vec4 col_rocksun = vec4(mix(col_step3, col_step2, 0.2));
    vec4 col_final = vec4(mix(col_sand, col_rocksun, 0.5));

    out_Col = col_final;
}
