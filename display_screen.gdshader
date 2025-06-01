shader_type canvas_item;
uniform sampler2D screen_texture : filter_nearest;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 p_uv = UV*vec2(16,9);
	vec2 sp_uv = p_uv*vec2(3,1);
	ivec2 sp_xy = ivec2(floor(sp_uv));
	vec3 pixel_colors = vec3(float(sp_xy.x%3 == 0),float(sp_xy.x%3 == 1),float(sp_xy.x%3 == 2));
	//float pixel_shading_x = 1.0-pow(0.5+0.5*sin(-(fract(sp_uv.x)-0.25)*2.0*PI),2.0);
	//float pixel_shading_y = 1.0-pow(0.5+0.5*sin(-(fract(sp_uv.y)-0.25)*2.0*PI),8.0);
	float pixel_shading_x = 1.0-(pow(abs(1.0-2.0*fract(sp_uv.x)),2.0));
	float pixel_shading_y = 1.0*(1.0-(pow(abs(1.0-2.0*fract(sp_uv.y)),3.0)));
	float pixel_shading = pixel_shading_x*pixel_shading_y;
	//float pixel_shading = min(pixel_shading_x,pixel_shading_y);
	//COLOR.rgb = texture(screen_texture,UV).rgb;
	//vec3 pixel_colors = max(vec3(sin(2.0*PI*sp_uv.x),sin(2.0*PI*(sp_uv.x+1.0/3.0)),sin(2.0*PI*(sp_uv.x+2.0/3.0))),vec3(0.0));
	float lcd_bleed = 1.0/50.0;
	vec3 lcd_color = lcd_bleed+(1.0-lcd_bleed)*texture(screen_texture,UV).rgb;
	float brightness = 3.0;
	//COLOR.rgb = brightness*texture(screen_texture,UV).rgb*pixel_colors*pixel_shading;
	COLOR.rgb = brightness*lcd_color*pixel_colors*pixel_shading;
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
