package control

import "../physics"
import rl "vendor:raylib"

Launcher :: struct {
	aiming:          bool,
	launch_position: rl.Vector2,
	launch_scale:    f32,
}

BeginAim :: proc(launcher: ^Launcher) {
	launcher.aiming = true
	launcher.launch_position = rl.GetMousePosition()
}

Release :: proc(launcher: ^Launcher) -> (physics.Particle, bool) {
	if !launcher.aiming {
		return {}, false
	}

  particle := PreviewParticle(launcher)
	launcher.aiming = false

	return particle, true
}

PreviewParticle :: proc(launcher: ^Launcher) -> physics.Particle {
	mouse_position := rl.GetMousePosition()

	particle := physics.CreateParticle(
		launcher.launch_position.x,
		launcher.launch_position.y,
		10,
		1,
		0,
		physics.World.gravity,
	)

	particle.velocity = {
		(launcher.launch_position.x - mouse_position.x) * launcher.launch_scale,
		(launcher.launch_position.y - mouse_position.y) * launcher.launch_scale,
	}

  return particle
}
