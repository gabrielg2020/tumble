package render

import "../physics"
import rl "vendor:raylib"

@(private)
draw_particle :: proc(particle: ^physics.Particle) {
	rl.DrawCircleV(
		world_to_screen(particle.position),
		particle.radius * PIXELS_PER_METRE,
		rl.RED,
	)
}
