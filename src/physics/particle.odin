package physics

Particle :: struct {
	position:     [2]f32, // Metres (x, y).
	radius:       f32, // Metres.
	mass:         f32, // Kilograms.
	velocity:     [2]f32, // Metres per second (x, y).
	acceleration: [2]f32, // Metres per second squared (x, y).
}

FIXED_DT :: f32(1.0 / 120.0) // Seconds; all physics dt arguments use seconds.

integrate_particle :: proc(particle: ^Particle, world: WorldConfig, dt: f32) {
	particle.acceleration = {0, world.gravity}
	particle.velocity += particle.acceleration * dt
	particle.position += particle.velocity * dt
}

check_particle_collisions :: proc(particle: ^Particle, world: WorldConfig) {
	if particle.position.y - particle.radius <= 0 {
		particle.position.y = particle.radius
		if particle.velocity.y < 0 {
			particle.velocity.y *= -world.restitution
		}
	}

	if particle.position.y + particle.radius >= world.dimensions.y {
		particle.position.y = world.dimensions.y - particle.radius
		if particle.velocity.y > 0 {
			particle.velocity.y *= -world.restitution
		}
	}

	if particle.position.x + particle.radius >= world.dimensions.x {
		particle.position.x = world.dimensions.x - particle.radius
		if particle.velocity.x > 0 {
			particle.velocity.x *= -world.restitution
		}
	}

	if particle.position.x - particle.radius <= 0 {
		particle.position.x = particle.radius
		if particle.velocity.x < 0 {
			particle.velocity.x *= -world.restitution
		}
	}
}
