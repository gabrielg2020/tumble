package main

import rl "vendor:raylib"
import "./physics"
import "./render"

main :: proc() {
  // create particle
  particle : physics.Particle = physics.CreateParticle(400, 300, 10, 1, 0, physics.Gravity)

	rl.InitWindow(800, 600, "tumble")
	defer rl.CloseWindow()

	rl.SetTargetFPS(60)

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()
		defer rl.EndDrawing()
    rl.ClearBackground(rl.GRAY)
		
    render.RenderParticleLoop(&particle)
	}
}


