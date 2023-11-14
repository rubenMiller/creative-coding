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

	public Vector2 transformIntoWorld(Vector2 pixelCoordinates)
	{
		//Console.WriteLine($"Pixel = {pixelCoordinates}");
		return pixelCoordinates.Transform(_view.Camera.GetWindowToWorld());
	}
}