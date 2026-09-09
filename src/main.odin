package main

import "./control"
import "./physics"
import "./render"
import rl "vendor:raylib"

main :: proc() {
	world := physics.WorldConfig {
		dimensions  = {8, 6},
		gravity     = 9.8,
		restitution = 0.8,
	}

	clock: SimulationClock
	launcher := control.Launcher {
		launch_scale = 3,
	}

	particles: [dynamic]ParticleInstance
	defer delete(particles)

	window_size := render.world_to_screen(world.dimensions)
	rl.InitWindow(i32(window_size.x), i32(window_size.y), "tumble")
	defer rl.CloseWindow()

	rl.SetTargetFPS(144)

	for !rl.WindowShouldClose() {
		update_controls(&launcher, &particles)

		advance_simulation(&clock, particles[:], world, rl.GetFrameTime())

		rl.BeginDrawing()
		defer rl.EndDrawing()
		rl.ClearBackground(rl.BLACK)

		for &instance in particles {
			render.draw(&instance.particle, &instance.trail)
		}

		if launcher.aiming {
			mouse_position := render.screen_to_world(rl.GetMousePosition())
			render.draw_preview(control.preview_particle(&launcher, mouse_position), world)
		}

		rl.DrawFPS(10, 10)

		free_all(context.temp_allocator)
	}
}
