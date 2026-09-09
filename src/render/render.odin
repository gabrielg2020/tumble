package render

import "../physics"

Draw :: proc(particle: ^physics.Particle, trail: ^Trail) {
  drawTrail(trail, particle.radius)
  RenderParticle(particle)
}

