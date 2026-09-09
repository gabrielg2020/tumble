package physics

import "core:testing"

@(private = "file")
test_particle :: proc() -> Particle {
	return Particle{position = {5, 5}, radius = 0.5, mass = 1}
}

@(private = "file")
test_world :: proc() -> WorldConfig {
	return WorldConfig{dimensions = {10, 10}, gravity = 9.8, restitution = 0.5}
}

@(test)
constant_velocity_without_gravity :: proc(t: ^testing.T) {
	particle := test_particle()
	particle.velocity = {2, -1}
	particle.acceleration = {3, 4}
	world := test_world()
	world.gravity = 0

	for _ in 0..<4 {
		integrate_particle(&particle, world, 0.25)
	}

	testing.expect_value(t, particle.position, [2]f32{7, 4})
	testing.expect_value(t, particle.velocity, [2]f32{2, -1})
	testing.expect_value(t, particle.acceleration, [2]f32{0, 0})
}

@(test)
free_fall_matches_semi_implicit_euler :: proc(t: ^testing.T) {
	particle := test_particle()
	particle.position = {0, 0}
	world := test_world()
	steps :: 120
	dt :: f32(1.0 / steps)

	for _ in 0..<steps {
		integrate_particle(&particle, world, dt)
	}

	// Summing v_k = k*g*dt gives y_n = g*dt^2*n*(n+1)/2, about 4.940833 m.
	expected_y := world.gravity * dt * dt * f32(steps * (steps + 1)) / 2
	// 2e-5 allows f32 accumulation round-off, well below the 0.040833 m Euler error.
	testing.expect(t, abs(particle.position.y - expected_y) < 2e-5)
	testing.expect(t, abs(particle.velocity.y - world.gravity) < 2e-5)
	testing.expect_value(t, particle.position.x, f32(0))
	testing.expect_value(t, particle.velocity.x, f32(0))
	testing.expect_value(t, particle.acceleration, [2]f32{0, world.gravity})
}

@(test)
free_fall_converges_to_analytical_displacement :: proc(t: ^testing.T) {
	world := test_world()
	errors: [2]f32

	for steps, index in ([2]int{120, 240}) {
		particle := test_particle()
		particle.position = {0, 0}
		dt := 1 / f32(steps)
		for _ in 0..<steps {
			integrate_particle(&particle, world, dt)
		}
		// From rest over one second, analytical displacement is g*t^2/2 = 4.9 m.
		errors[index] = particle.position.y - 4.9
	}

	testing.expect(t, errors[0] > 0)
	testing.expect(t, errors[1] > 0)
	testing.expect(t, errors[1] < errors[0])
	// First-order Euler error halves with dt; 3e-5 covers round-off in both runs
	// while remaining under 0.15% of the finer run's roughly 0.020417 m error.
	testing.expect(t, abs(errors[1] - errors[0] / 2) < 3e-5)
}

@(test)
gravity_change_updates_existing_particle :: proc(t: ^testing.T) {
	particle := test_particle()
	world := test_world()
	world.gravity = 8
	integrate_particle(&particle, world, 0.25)
	world.gravity = -4
	integrate_particle(&particle, world, 0.25)

	testing.expect_value(t, particle.acceleration, [2]f32{0, -4})
	testing.expect_value(t, particle.velocity, [2]f32{0, 1})
	testing.expect_value(t, particle.position, [2]f32{5, 5.75})
}

@(test)
wall_collisions_correct_and_reflect_incoming_velocity :: proc(t: ^testing.T) {
	world := test_world()
	cases := [?]struct {
		name:               string,
		position:           [2]f32,
		velocity:           [2]f32,
		corrected_position: [2]f32,
		reflected_velocity: [2]f32,
	}{
		{"top", {5, 0.25}, {3, -4}, {5, 0.5}, {3, 2}},
		{"bottom", {5, 9.75}, {3, 4}, {5, 9.5}, {3, -2}},
		{"left", {0.25, 5}, {-4, 3}, {0.5, 5}, {2, 3}},
		{"right", {9.75, 5}, {4, 3}, {9.5, 5}, {-2, 3}},
	}

	for wall in cases {
		for touching in ([2]bool{false, true}) {
			particle := test_particle()
			particle.position = touching ? wall.corrected_position : wall.position
			particle.velocity = wall.velocity
			check_particle_collisions(&particle, world)

			testing.expectf(t, particle.position == wall.corrected_position,
				"%s wall (touching=%v): position %v", wall.name, touching, particle.position)
			testing.expectf(t, particle.velocity == wall.reflected_velocity,
				"%s wall (touching=%v): velocity %v", wall.name, touching, particle.velocity)

			// A particle already moving away from the wall must not bounce again.
			particle.position = touching ? wall.corrected_position : wall.position
			particle.velocity = wall.reflected_velocity
			check_particle_collisions(&particle, world)

			testing.expectf(t, particle.position == wall.corrected_position,
				"%s wall leaving (touching=%v): position %v", wall.name, touching, particle.position)
			testing.expectf(t, particle.velocity == wall.reflected_velocity,
				"%s wall leaving (touching=%v): velocity %v", wall.name, touching, particle.velocity)
		}
	}
}

@(test)
interior_particle_is_unchanged_by_collisions :: proc(t: ^testing.T) {
	particle := test_particle()
	particle.velocity = {3, -4}
	particle.acceleration = {0, 9.8}
	before := particle

	check_particle_collisions(&particle, test_world())

	testing.expect_value(t, particle, before)
}
