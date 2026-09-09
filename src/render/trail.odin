package render

import rl "vendor:raylib"

@(private = "file")
MAX_TRAIL_LENGTH :: 100

Trail :: struct {
	points: [MAX_TRAIL_LENGTH][2]f32,
	head:   int,
	count:  int,
}

record_trail :: proc(trail: ^Trail, position: [2]f32) {
	trail.points[trail.head] = position
	trail.head = (trail.head + 1) % MAX_TRAIL_LENGTH
	if trail.count < MAX_TRAIL_LENGTH {
		trail.count += 1
	}
}

@(private)
draw_trail :: proc(trail: ^Trail, radius: f32) {
	for i in 0 ..< trail.count {
		index := (trail.head - trail.count + i + MAX_TRAIL_LENGTH) % MAX_TRAIL_LENGTH
		alpha := f32(i + 1) / f32(trail.count)
		colour := rl.Fade(rl.GRAY, alpha)
		rl.DrawCircleV(
			world_to_screen(trail.points[index]),
			radius * PIXELS_PER_METRE * alpha,
			colour,
		)
	}
}
