package main

import "./physics"

UpdateSimulation :: proc(particles: []ParticleInstance, dt: f32) {
  for &instance in particles {
    physics.IntergrateParticle(&instance.particle, dt)
    physics.CheckParticleCollisions(&instance.particle)
  }
}
