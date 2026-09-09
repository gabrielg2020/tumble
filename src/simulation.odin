package main

import "./physics"
import "./render"

SimulationClock :: struct {
  accumulator: f64,
}

AdvanceSimulation :: proc (
  clock: ^SimulationClock,
  particles: []ParticleInstance,
  frame_dt: f32,
  ) {
  max_steps_per_frame :: 16
  fixed_dt := f64(physics.FixedDT)
  max_frame_dt := fixed_dt * f64(max_steps_per_frame)

  clock.accumulator += min(f64(frame_dt), max_frame_dt)

  for clock.accumulator >= fixed_dt {
    UpdateSimulation(particles, physics.FixedDT)
    clock.accumulator -= fixed_dt
  }
}

UpdateSimulation :: proc(particles: []ParticleInstance, dt: f32) {
  for &instance in particles {
    physics.IntergrateParticle(&instance.particle, dt)
    physics.CheckParticleCollisions(&instance.particle)
    render.RecordTrail(&instance.trail, instance.particle.position)
  }
}
