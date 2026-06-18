package render

import "../physics"
import rl "vendor:raylib"


RenderParticleLoop :: proc (particle: ^physics.Particle) {
  renderParticle(particle)
  dt : f32 = rl.GetFrameTime()
  physics.CalculateParticleVelocity(particle, dt)
  physics.CalculateParticlePosition(particle, dt) 
}

// -- private

@(private="file")
renderParticle :: proc(particle: ^physics.Particle) {
	rl.DrawCircleV(rl.Vector2{particle.position.x, particle.position.y}, particle.radius, rl.RED)
}
