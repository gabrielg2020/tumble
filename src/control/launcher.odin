package control

import "../physics"

Launcher :: struct {
	aiming:          bool,
	launch_position: [2]f32,
	launch_scale:    f32,
}

BeginAim :: proc(launcher: ^Launcher, position: [2]f32) {
	launcher.aiming = true
	launcher.launch_position = position
}

Release :: proc(launcher: ^Launcher, position: [2]f32) -> (physics.Particle, bool) {
	if !launcher.aiming {
		return {}, false
	}

	particle := PreviewParticle(launcher, position)
	launcher.aiming = false

	return particle, true
}

PreviewParticle :: proc(launcher: ^Launcher, position: [2]f32) -> physics.Particle {
	particle := physics.CreateParticle(
		launcher.launch_position.x,
		launcher.launch_position.y,
		0.1,
		1,
		0,
		physics.World.gravity,
	)

	particle.velocity = {
		(launcher.launch_position.x - position.x) * launcher.launch_scale,
		(launcher.launch_position.y - position.y) * launcher.launch_scale,
	}

	return particle
}
