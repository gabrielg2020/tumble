package render

import "../physics"
import rl "vendor:raylib"

@(private)
renderParticle :: proc(particle: ^physics.Particle) {
	rl.DrawCircleV(rl.Vector2{particle.position.x, particle.position.y}, particle.radius, rl.RED)
}
