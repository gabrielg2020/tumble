package control

import "../physics"

Launcher :: struct {
	aiming:          bool,
	launch_position: [2]f32,
	launch_scale:    f32,
}

begin_aim :: proc(launcher: ^Launcher, position: [2]f32) {
	launcher.aiming = true
	launcher.launch_position = position
}

release :: proc(launcher: ^Launcher, position: [2]f32) -> (physics.Particle, bool) {
	if !launcher.aiming {
		return {}, false
	}

	particle := preview_particle(launcher, position)
	launcher.aiming = false

	return particle, true
}

preview_particle :: proc(launcher: ^Launcher, position: [2]f32) -> physics.Particle {
	return physics.Particle {
		position = launcher.launch_position,
		radius   = 0.1,
		mass     = 1,
		velocity = (launcher.launch_position - position) * launcher.launch_scale,
	}
}
