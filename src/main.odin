package main

import "./physics"
import "./render"
import rl "vendor:raylib"

main :: proc() {
	particle: physics.Particle = physics.CreateParticle(400, 300, 10, 1, 0, physics.World.gravity)

	rl.InitWindow(i32(physics.World.dimentions[0]), i32(physics.World.dimentions[1]), "tumble")
	defer rl.CloseWindow()

	rl.SetTargetFPS(144)

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()
		defer rl.EndDrawing()
		rl.ClearBackground(rl.BLACK)

		render.Step(&particle)
		rl.DrawFPS(10, 10)
	}
}
