package main

import "./physics"
import "./render"

SimulationClock :: struct {
	accumulator: f64,
}

advance_simulation :: proc(
	clock: ^SimulationClock,
	particles: []ParticleInstance,
	world: physics.WorldConfig,
	frame_dt: f32,
) {
	max_steps_per_frame :: 16
	fixed_dt := f64(physics.FIXED_DT)
	max_frame_dt := fixed_dt * f64(max_steps_per_frame)

	// Discard excess wall-clock time to bound catch-up work after a slow frame.
	clock.accumulator += min(f64(frame_dt), max_frame_dt)

	for clock.accumulator >= fixed_dt {
		update_simulation(particles, world, physics.FIXED_DT)
		clock.accumulator -= fixed_dt
	}
}

update_simulation :: proc(particles: []ParticleInstance, world: physics.WorldConfig, dt: f32) {
	for &instance in particles {
		physics.integrate_particle(&instance.particle, world, dt)
		physics.check_particle_collisions(&instance.particle, world)
		render.record_trail(&instance.trail, instance.particle.position)
	}
}
