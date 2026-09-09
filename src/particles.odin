package main

import "./physics"
import "./render"

ParticleInstance :: struct {
	particle: physics.Particle,
	trail:    render.Trail,
}
