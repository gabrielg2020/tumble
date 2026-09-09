package main

import "./control"
import "./render"
import rl "vendor:raylib"

UpdateControls :: proc(launcher: ^control.Launcher, particles: ^[dynamic]ParticleInstance) {
  mouse_position := render.ScreenToWorld(rl.GetMousePosition())
	if rl.IsMouseButtonPressed(.LEFT) {
		control.BeginAim(launcher, mouse_position)
	}

	if rl.IsMouseButtonReleased(.LEFT) {
		particle, launched := control.Release(launcher, mouse_position)
		if launched {
			append(particles, ParticleInstance{particle = particle})
		}
	}
}
