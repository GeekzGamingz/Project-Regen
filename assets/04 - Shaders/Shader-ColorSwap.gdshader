shader_type canvas_item;
const float EPSILON = 0.0001;
// Old Color #1
uniform vec4 old_outline1 : source_color;
uniform vec4 old_shadow1 : source_color;
uniform vec4 old_base1 : source_color;
uniform vec4 old_highlight1 : source_color;
// Old Color #2
uniform vec4 old_outline2 : source_color;
uniform vec4 old_shadow2 : source_color;
uniform vec4 old_base2 : source_color;
uniform vec4 old_highlight2 : source_color;
// Old Eyes
uniform vec4 old_outline3 : source_color;
uniform vec4 old_shadow3 : source_color;
uniform vec4 old_base3 : source_color;
uniform vec4 old_highlight3 : source_color;
// New Outline #1
uniform vec4 new_outline1 : source_color;
uniform vec4 new_shadow1 : source_color;
uniform vec4 new_base1 : source_color;
uniform vec4 new_highlight1 : source_color;
// New Outline #2
uniform vec4 new_outline2 : source_color;
uniform vec4 new_shadow2 : source_color;
uniform vec4 new_base2 : source_color;
uniform vec4 new_highlight2 : source_color;
// New Eyes
uniform vec4 new_outline3 : source_color;
uniform vec4 new_shadow3 : source_color;
uniform vec4 new_base3 : source_color;
uniform vec4 new_highlight3 : source_color;

void fragment() {
    vec4 curr_color = texture(TEXTURE,UV); // Get Current Color

	// Checks Current Pixel Color to old_
	// Swaps Current Pixel Color to new_
	// Color One
	if (length(curr_color - old_outline1) < EPSILON)
	{
		COLOR = new_outline1;
	}
	else if (length(curr_color - old_shadow1) < EPSILON)
	{
        COLOR = new_shadow1;
    }
    else if (length(curr_color - old_base1) < EPSILON)
	{
        COLOR = new_base1;
    }
	else if (length(curr_color - old_highlight1) < EPSILON)
	{
        COLOR = new_highlight1;
    }
	// Color Two
	else if (length(curr_color - old_outline2) < EPSILON)
	{
		COLOR = new_outline2;
	}
	else if (length(curr_color - old_shadow2) < EPSILON)
	{
        COLOR = new_shadow2;
    }
	else if (length(curr_color - old_base2) < EPSILON)
	{
        COLOR = new_base2;
    }
	else if (length(curr_color - old_highlight2) < EPSILON)
	{
        COLOR = new_highlight2;
    }
	// Eye One
	else if (length(curr_color - old_outline3) < EPSILON)
	{
        COLOR = new_outline1;
    }
	else if (length(curr_color - old_shadow3) < EPSILON)
	{
        COLOR = new_shadow3;
    }
	// Eye Two
	else if (length(curr_color - old_base3) < EPSILON)
	{
        COLOR = new_base3;
    }
	else if (length(curr_color - old_highlight3) < EPSILON)
	{
        COLOR = new_highlight3;
    }
	else
	{
		// Keeps Original
        COLOR = curr_color;
    }
}