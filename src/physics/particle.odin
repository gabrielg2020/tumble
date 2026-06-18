package physics

import "core:fmt"
Particle :: struct {
	position:     [2]f32, // 0: x, 1: y
	radius:       f32,
	mass:         f32,
	velocity:     [2]f32, // 0 vx, 1: vy
	acceleration: [2]f32, // 0 ax, 1: ay
}

CreateParticle :: proc(x, y, radius, mass, ax, ay: f32) -> Particle {
	return Particle{{x, y}, radius, mass, {0, 0}, {ax, ay}}
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

CheckParticleCollisions :: proc(particle: ^Particle) {
  if IsCollidingWithXPlane(particle.position[1] + particle.radius) {
    particle.velocity[1] *= -1
  }

  if IsCollidingWithYPlane(particle.position[0] + particle.radius) {
    particle.velocity[0] *= -1
  }
}
