package render

import rl "vendor:raylib"

PIXELS_PER_METRE :: f32(100) // 100 pixels = 1 metre

world_to_screen :: proc(position: [2]f32) -> rl.Vector2 {
	return {
		position.x * PIXELS_PER_METRE,
		position.y * PIXELS_PER_METRE,
	}
}

screen_to_world :: proc(position: rl.Vector2) -> [2]f32 {
	return {
		position.x / PIXELS_PER_METRE,
		position.y / PIXELS_PER_METRE,
	}
}
