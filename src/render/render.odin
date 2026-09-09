package render

import "../physics"

draw :: proc(particle: ^physics.Particle, trail: ^Trail) {
	draw_trail(trail, particle.radius)
	draw_particle(particle)
}
