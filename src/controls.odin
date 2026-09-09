package main

import "./control"
import "./render"
import rl "vendor:raylib"

update_controls :: proc(launcher: ^control.Launcher, particles: ^[dynamic]ParticleInstance) {
	mouse_position := render.screen_to_world(rl.GetMousePosition())
	if rl.IsMouseButtonPressed(.LEFT) {
		control.begin_aim(launcher, mouse_position)
	}

	if rl.IsMouseButtonReleased(.LEFT) {
		particle, launched := control.release(launcher, mouse_position)
		if launched {
			append(particles, ParticleInstance{particle = particle})
		}
	}
}
