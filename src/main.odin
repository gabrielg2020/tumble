package main

import "./control"
import "./physics"
import "./render"
import rl "vendor:raylib"

main :: proc() {
  clock: SimulationClock
	launcher := control.Launcher{launch_scale = 3}

	particles: [dynamic]ParticleInstance
	defer delete(particles)

	rl.InitWindow(i32(physics.World.dimentions[0]), i32(physics.World.dimentions[1]), "tumble")
	defer rl.CloseWindow()

	rl.SetTargetFPS(144)

	for !rl.WindowShouldClose() {
		UpdateControls(&launcher, &particles)

    AdvanceSimulation(&clock, particles[:], rl.GetFrameTime())

		rl.BeginDrawing()
		defer rl.EndDrawing()
		rl.ClearBackground(rl.BLACK)

		for &instance in particles {
			render.Draw(&instance.particle, &instance.trail)
		}

    if launcher.aiming {
      render.DrawPreview(control.PreviewParticle(&launcher))
    }

		rl.DrawFPS(10, 10)

		free_all(context.temp_allocator) // reclaim the memory allcoated to stats page
	}
}
