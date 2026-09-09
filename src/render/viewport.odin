package render

import rl "vendor:raylib"

PixelsPerMetre :: f32(100) // 100 pixels = 1 metre

WorldToScreen :: proc(position: [2]f32) -> rl.Vector2 {
  return {
    position.x * PixelsPerMetre,
    position.y * PixelsPerMetre
  }
}

ScreenToWorld :: proc(position: rl.Vector2) -> [2]f32 {
  return {
    position.x / PixelsPerMetre,
    position.y / PixelsPerMetre,
  }
}
