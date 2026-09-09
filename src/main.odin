package main

import "./control"
import "./physics"
import "./render"
import rl "vendor:raylib"

main :: proc() {
	launcher := control.Launcher{launch_scale = 3}

	particles: [dynamic]ParticleInstance
	defer delete(particles)

	// temporary test of array rendering
	append(
		&particles,
		ParticleInstance {
			particle = physics.CreateParticle(300, 200, 10, 1, 0, physics.World.gravity),
		},
		ParticleInstance {
			particle = physics.CreateParticle(500, 300, 10, 1, 0, physics.World.gravity),
		},
	)

	rl.InitWindow(i32(physics.World.dimentions[0]), i32(physics.World.dimentions[1]), "tumble")
	defer rl.CloseWindow()

	rl.SetTargetFPS(144)

	for !rl.WindowShouldClose() {
		UpdateControls(&launcher, &particles)

		rl.BeginDrawing()
		defer rl.EndDrawing()
		rl.ClearBackground(rl.BLACK)

		for &instance in particles {
			render.Step(&instance.particle, &instance.trail)
		}

		rl.DrawFPS(10, 10)

		free_all(context.temp_allocator) // reclaim the memory allcoated to stats page
	}
}
