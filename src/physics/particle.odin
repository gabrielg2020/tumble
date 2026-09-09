package physics

Particle :: struct {
	position:     [2]f32, // Metres (x, y).
	radius:       f32, // Metres.
	mass:         f32, // Kilograms.
	velocity:     [2]f32, // Metres per second (x, y).
	acceleration: [2]f32, // Metres per second squared (x, y).
}

FixedDT :: f32(1.0 / 120.0) // Seconds; all physics dt arguments use seconds.

CreateParticle :: proc(x, y, radius, mass, ax, ay: f32) -> Particle {
	return Particle{{x, y}, radius, mass, {0, 0}, {ax, ay}}
}

IntegrateParticle :: proc(particle: ^Particle, world: WorldConfig, dt: f32) {
	particle.acceleration = {0, world.gravity}
	CalculateParticleVelocity(particle, dt)
	CalculateParticlePosition(particle, dt)
}

CalculateParticleVelocity :: proc(particle: ^Particle, dt: f32) {
	calculatedVelocity: [2]f32 = CalculateVelocity(particle.acceleration, dt)
	particle.velocity[0] += calculatedVelocity[0]
	particle.velocity[1] += calculatedVelocity[1]
}

CalculateParticlePosition :: proc(particle: ^Particle, dt: f32) {
	calculatedPosition: [2]f32 = CalculatePosition(particle.velocity, dt)
	particle.position[0] += calculatedPosition[0]
	particle.position[1] += calculatedPosition[1]
}

CheckParticleCollisions :: proc(particle: ^Particle, world: WorldConfig) {
	if IsCollidingWithTopWall(particle.position.y - particle.radius) {
		particle.position[1] = particle.radius
		particle.velocity[1] *= -world.restitution
	}

	if IsCollidingWithBottomWall(particle.position.y + particle.radius, world.dimensions.y) {
		particle.position[1] = world.dimensions[1] - particle.radius
		particle.velocity[1] *= -world.restitution
	}

	if IsCollidingWithRightWall(particle.position.x + particle.radius, world.dimensions.x) {
		particle.position[0] = world.dimensions[0] - particle.radius
		particle.velocity[0] *= -world.restitution
	}

	if IsCollidingWithLeftWall(particle.position.x - particle.radius) {
		particle.position[0] = particle.radius
		particle.velocity[0] *= -world.restitution
	}
}
