package render

import "../physics"

Draw :: proc(particle: ^physics.Particle, trail: ^Trail) {
  trailPush(trail, particle.position)
  drawTrail(trail, particle.radius)
  RenderParticle(particle)
}

