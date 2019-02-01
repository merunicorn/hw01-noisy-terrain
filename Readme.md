Amy Chen
amyjchen

Adam’s Lava: https://www.shadertoy.com/view/WsSGDw
Conceptual reference: https://www.shadertoy.com/view/XdyfR1
GraphToy for remapping: http://www.iquilezles.org/apps/graphtoy/
Cosine palette: http://dev.thi.ng/gradients/

Geometry:
Sand: FBM
Sunlight: Worley 
Rocks: FBM(Worley), remapped so rocks were dispersed / not all over
Colors:
Sand: Flat color mixed with the FBM used to create the sand so there was shading corresponding to the geometry.
Sunlight: Cosine palette
Rocks: Colored based on height / if there were rocks; Cosine palette
Got overall color by mixing between sand/sunlight and rock/sunlight so that the worley sunlight effect was overlaid on top of the colors.
