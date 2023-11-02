using OpenTK.Mathematics;
using OpenTK.Windowing.GraphicsLibraryFramework;
using System;
using Zenseless.OpenTK;

namespace Example;

internal class Controller
{
	private readonly Model _model;
	private readonly View _view;

	public Controller(Model model, View view)
	{
		_model = model;
		_view = view;
	}

	internal void Update(float deltaTime, KeyboardState keyboard, MouseState mouseState)
	{
		//Axis gives 0 if no key is pressed; -1 if the negative key is pressed and 1 if the positive key is pressed
		float Axis(Keys negative, Keys positive) => keyboard.IsKeyDown(negative) ? -1f : keyboard.IsKeyDown(positive) ? 1f : 0f;

		var axisZoom = mouseState.ScrollDelta.Y; // mouse wheel
		axisZoom += 0.2f * Axis(Keys.PageDown, Keys.PageUp);

		var camera = _view.Camera;

		// zoom
		var zoom = camera.Scale * (1 + deltaTime * 5f * axisZoom);
		// set the zoom scale here
		zoom = MathHelper.Clamp(zoom, 1f, 20f);
		camera.Scale = zoom;

		// rotate
		float rotate = Axis(Keys.E, Keys.Q);
		camera.Rotation += 100f * rotate * deltaTime;

		// Translate
		float axisLeftRight = Axis(Keys.A, Keys.D);
		float axisUpDown = Axis(Keys.S, Keys.W);
		var movement = deltaTime * new Vector2(axisLeftRight, axisUpDown);
		// Convert movement from camera space into world space
		camera.Center += movement.TransformDirection(camera.CameraMatrix.Inverted());
	}
	/*
		internal void Click(Vector2 pixelCoordinates)
		{
			Console.WriteLine($"Pixel = {pixelCoordinates}");
			// Transform the pixel coordinates into world
			var world = pixelCoordinates.Transform(_view.Camera.GetWindowToWorld());
			Console.WriteLine($"World = {world}");
			// Check if coordinates are inside the grid
			if (world.X < 0 || _model.Grid.Columns < world.X) return;
			if (world.Y < 0 || _model.Grid.Rows < world.Y) return;
			// Calculate grid cell
			var column = (int)Math.Truncate(world.X);
			var row = (int)Math.Truncate(world.Y);
			Console.WriteLine($"Grid = {column}, {row}");
			_model.ClearCell(column, row);
		}*/
}