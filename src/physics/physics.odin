package physics

@(private)
CalculateVelocity :: proc (acceleration : [2]f32, dt : f32) -> [2]f32 {
  return {
    acceleration[0] * dt, 
    acceleration[1] * dt
  } 
}

@(private)
CalculatePosition :: proc (velocity : [2]f32, dt : f32) -> [2]f32 {
  return {
    velocity[0] * dt,
    velocity[1] * dt
  }
}

@(private)
IsCollidingWithXPlane :: proc (y : f32) -> bool {
  if y <= 0 || y >= World.dimentions[1]{
    return true
  }
  return false
}

@(private)
IsCollidingWithYPlane :: proc (x : f32) -> bool {
  if x <= 0 || x >= World.dimentions[0] {
    return true
  }
  return false
}
