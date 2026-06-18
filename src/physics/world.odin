package physics

WorldState :: struct {
	dimentions:  [2]f32, // 0: length,  1: height
	gravity:     f32,
	restitution: f32, // 1.0 = full energy conservation
}

World :: WorldState{{800, 600}, 9.8, 0.8}
