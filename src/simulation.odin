package main

import "./physics"
import "./render"

SimulationClock :: struct {
	accumulator: f64,
}

AdvanceSimulation :: proc(
	clock: ^SimulationClock,
	particles: []ParticleInstance,
	world: physics.WorldConfig,
	frame_dt: f32,
) {
	max_steps_per_frame :: 16
	fixed_dt := f64(physics.FixedDT)
	max_frame_dt := fixed_dt * f64(max_steps_per_frame)

	clock.accumulator += min(f64(frame_dt), max_frame_dt)

	for clock.accumulator >= fixed_dt {
		UpdateSimulation(particles, world, physics.FixedDT)
		clock.accumulator -= fixed_dt
	}
}

UpdateSimulation :: proc(particles: []ParticleInstance, world: physics.WorldConfig, dt: f32) {
	for &instance in particles {
		physics.IntegrateParticle(&instance.particle, world, dt)
		physics.CheckParticleCollisions(&instance.particle, world)
		render.RecordTrail(&instance.trail, instance.particle.position)
	}
}
