package render

import "../physics"
import "core:fmt"
import rl "vendor:raylib"

@(private)
RenderParticle :: proc(particle: ^physics.Particle) {
	rl.DrawCircleV(rl.Vector2{particle.position.x, particle.position.y}, particle.radius, rl.RED)
}

@(private)
DrawStats :: proc(particle: ^physics.Particle) {
	x: i32 = 10
	size: i32 = 20
	rl.DrawText(
		fmt.ctprintf("pos: %.1f, %.1f", particle.position.x, particle.position.y),
		x,
		40,
		size,
		rl.WHITE,
	)
	rl.DrawText(
		fmt.ctprintf("vel: %.1f, %.1f", particle.velocity.x, particle.velocity.y),
		x,
		64,
		size,
		rl.WHITE,
	)
	rl.DrawText(
		fmt.ctprintf("acc: %.1f, %.1f", particle.acceleration.x, particle.acceleration.y),
		x,
		88,
		size,
		rl.WHITE,
	)
	rl.DrawText(
		fmt.ctprintf("mass: %.1f  r: %.1f", particle.mass, particle.radius),
		x,
		112,
		size,
		rl.WHITE,
	)
}
