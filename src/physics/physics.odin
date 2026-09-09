package physics

@(private)
CalculateVelocity :: proc(acceleration: [2]f32, dt: f32) -> [2]f32 {
	return {acceleration[0] * dt, acceleration[1] * dt}
}

@(private)
CalculatePosition :: proc(velocity: [2]f32, dt: f32) -> [2]f32 {
	return {velocity[0] * dt, velocity[1] * dt}
}

@(private)
IsCollidingWithTopWall :: proc(y: f32) -> bool {
	return y <= 0
}

@(private)
IsCollidingWithBottomWall :: proc(y: f32, height: f32) -> bool {
  return y >= height
}

@(private)
IsCollidingWithRightWall :: proc(x: f32, width: f32) -> bool {
	return x >= width
}

@(private)
IsCollidingWithLeftWall :: proc(x: f32) -> bool {
	return x <= 0
}
