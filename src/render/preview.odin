package render

import "../physics"
import rl "vendor:raylib"

DrawPreview :: proc(particle: physics.Particle, world: physics.WorldConfig) {
	predicted := particle

	steps_per_dot :: 12
	dot_count :: 3

	for _ in 0 ..< dot_count {
		for _ in 0 ..< steps_per_dot {
			physics.IntegrateParticle(&predicted, world, physics.FixedDT)

			if predicted.position.x - predicted.radius <= 0 ||
			   predicted.position.x + predicted.radius >= world.dimensions[0] ||
			   predicted.position.y - predicted.radius <= 0 ||
			   predicted.position.y + predicted.radius >= world.dimensions[1] {
				return
			}
		}

		rl.DrawCircleV(WorldToScreen(predicted.position), 3, rl.WHITE)
	}
}
