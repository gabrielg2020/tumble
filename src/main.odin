package main

import "./physics"
import "./render"
import rl "vendor:raylib"

ParticleInstanse :: struct {
  particle: physics.Particle,
  trail:    render.Trail,
}

main :: proc() {
  partcles: [dynamic]ParticleInstanse
  defer delete(partcles)

  // temporary test of array rendering
  append(&partcles,
    ParticleInstanse{
      particle = physics.CreateParticle(300,200,10,1,0, physics.World.gravity),
    },
    ParticleInstanse{
      particle = physics.CreateParticle(500, 300, 10, 1, 0, physics.World.gravity),
    },
  )

	rl.InitWindow(i32(physics.World.dimentions[0]), i32(physics.World.dimentions[1]), "tumble")
	defer rl.CloseWindow()

	rl.SetTargetFPS(144)

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()
		defer rl.EndDrawing()
		rl.ClearBackground(rl.BLACK)

    for &instance in partcles {
      render.Step(&instance.particle, &instance.trail)
    }

		rl.DrawFPS(10, 10)

    free_all(context.temp_allocator) // reclaim the memory allcoated to stats page
	}
}
