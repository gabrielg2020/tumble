package render

import rl "vendor:raylib"

maxTrailLength: int : 100

Trail :: struct {
	points: [maxTrailLength][2]f32,
	head:   int,
	count:  int,
}

@(private)
trailPush :: proc(trail: ^Trail, p: [2]f32) {
	trail.points[trail.head] = p
	trail.head = (trail.head + 1) % maxTrailLength
	if trail.count < maxTrailLength {
		trail.count += 1
	}
}

@(private)
drawTrail :: proc(trail: ^Trail, radius: f32) {
	for i in 0 ..< trail.count {
		idx: int = (trail.head - trail.count + i + maxTrailLength) % maxTrailLength
		alpha: f32 = f32(i + 1) / f32(trail.count)
		col: rl.Color = rl.Fade(rl.GRAY, alpha)
		rl.DrawCircleV(rl.Vector2{trail.points[idx].x, trail.points[idx].y}, radius * alpha, col)
	}
}
