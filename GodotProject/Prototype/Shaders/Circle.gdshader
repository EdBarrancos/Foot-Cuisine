shader_type canvas_item;

uniform float circle_size : hint_range(0,1) = 0.5f;
uniform vec4 circle_color: hint_color = vec4(0);
uniform vec2 circle_center = vec2(0.5,0.5);

uniform float inner_alpha : hint_range(0,1) = 0.3f;

void fragment(){
	COLOR = circle_color;
	COLOR.a = 0f;
	if (distance(circle_center, UV) < circle_size){
		COLOR.a = inner_alpha;
	}
}