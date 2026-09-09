package main

import "./control"
import rl "vendor:raylib"

UpdateControls :: proc(launcher: ^control.Launcher, particles: ^[dynamic]ParticleInstance) {
	if rl.IsMouseButtonPressed(.LEFT) {
		control.BeginAim(launcher)
	}

	if rl.IsMouseButtonReleased(.LEFT) {
		particle, launched := control.Release(launcher)
		if launched {
			append(particles, ParticleInstance{particle = particle})
		}
	}
}
