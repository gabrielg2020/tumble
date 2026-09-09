package physics

WorldConfig :: struct {
	dimensions:  [2]f32, // Width and height in metres.
	gravity:     f32, // Metres per second squared; positive Y points down.
	restitution: f32, // Dimensionless; 1.0 is a perfectly elastic bounce.
}
