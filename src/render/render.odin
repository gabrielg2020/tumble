package render

import "../physics"
import rl "vendor:raylib"


Step :: proc(particle: ^physics.Particle, trail: ^Trail) {
  trailPush(trail, particle.position)
  drawTrail(trail, particle.radius)
	renderParticle(particle)

	dt: f32 = rl.GetFrameTime()
	physics.CalculateParticleVelocity(particle, dt)
	physics.CalculateParticlePosition(particle, dt)
	physics.CheckParticleCollisions(particle)
}

