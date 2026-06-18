package physics

Gravity: f32 : 9.8

Particle :: struct {
	position:     [2]f32,
	radius:       f32,
	mass:         f32,
	velocity:     [2]f32,
	acceleration: [2]f32,
}

CreateParticle :: proc(x, y, radius, mass, ax, ay: f32) -> Particle {
	return Particle{{x, y}, radius, mass, {0, 0}, {ax, ay}}
}

CalculateParticleVelocity :: proc(particle: ^Particle, dt: f32) {
	particle.velocity[0] += particle.acceleration[0] * dt
	particle.velocity[1] += particle.acceleration[1] * dt
}

CalculateParticlePosition :: proc(particle: ^Particle, dt: f32) {
	particle.position[0] += particle.velocity[0] * dt
	particle.position[1] += particle.velocity[1] * dt
}
