/*{ "osc": 4000, "server": 3000 }*/
#ifdef GL_ES
precision mediump float;
#endif

#extension GL_OES_standard_derivatives : enable

uniform float time;
uniform vec2 mouse;
uniform vec2 resolution;


uniform sampler2D osc_lfo;      // OSC on /foo
uniform sampler2D osc_noise;  // OSC on /foo/bar
//
// Basically, If I can figure out how to change say, c1 - mouse.x to the OSC values osc_lfo, 0 to 1 (float)
// Then I should be able to translate it to other shaders..
//

float gridDE(vec2 p) {

	float size = 0.005;
	float c1 = mod(p.y-size, abs(mouse.y-0.5));
	float c2 = mod(p.y+size, abs(mouse.y-0.5));
	float diff = abs(c1-c2);
	c1 = mod(p.x-size, abs(mouse.x-0.5));
	c2 = mod(p.x+size, abs(mouse.x-0.5));
	diff += abs(c1-c2);
	if (diff > 0.05) diff = 1.0;
	return diff;
}

void main( void ) {

	vec2 pos = ( gl_FragCoord.xy / resolution.xy );
	pos -= vec2(0.5,0.5);

	float d = gridDE(pos);
	gl_FragColor = vec4( d,d,d, 1.0 );

}
