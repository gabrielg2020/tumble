package render

import "../physics"
import rl "vendor:raylib"

DrawPreview :: proc(particle: physics.Particle) {
	predicted := particle

	step: f32 = 1.0 / 120.0
	steps_per_dot :: 100
	dot_count :: 3

	for _ in 0 ..< dot_count {
		for _ in 0 ..< steps_per_dot {
			physics.CalculateParticleVelocity(&predicted, step)
			physics.CalculateParticlePosition(&predicted, step)

			if predicted.position.x - predicted.radius <= 0 ||
			   predicted.position.x + predicted.radius >= physics.World.dimentions[0] ||
			   predicted.position.y - predicted.radius <= 0 ||
			   predicted.position.y + predicted.radius >= physics.World.dimentions[1] {
				return
			}
		}

		rl.DrawCircleV(rl.Vector2{predicted.position.x, predicted.position.y}, 3, rl.WHITE)
	}
}
