using OpenTK.Graphics.OpenGL;
using OpenTK.Mathematics;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Linq;
using Zenseless.Spatial;

namespace Example;

/// <summary>
/// Class that handles all the actual drawing using OpenGL.
/// </summary>
internal class View
{
	public View()
	{
		Camera.Scale = 9f;
		Camera.Center = new Vector2(10f, 7f);
	}

	internal Camera Camera { get; } = new Camera();

	internal void Draw(Model model)
	{
		GL.Clear(ClearBufferMask.ColorBufferBit); // clear the screen

		Camera.SetMatrix();

		DrawMap(model);
		//DrawGrid(model.Grid);
	}

	internal void Resize(int width, int height)
	{
		Camera.Resize(width, height);
	}

	private readonly List<Vector2> circlePoints = CreateCirclePoints(20);

	private void DrawCircle(Vector2 center, float radius)
	{
		GL.Begin(PrimitiveType.Polygon);
		foreach (var point in circlePoints)
		{
			GL.Vertex2(center + radius * point);
		}
		GL.End();
	}

	private void DrawMap(Model model)
	{
		//WriteLine(model.astar.startNode + ", " + model.astar.endNode);
		Vector4 red = (1f, 0, 0, 1f);
		Vector4 white = (0.3f, 0.3f, 0.3f, 1f);

		// Draw the points the path is searched from
		GL.Color4(red);
		if (model.astar.startNode >= 0)
		{
			Vector2 start = new Vector2((float)model.astar.nodes[model.astar.startNode][0], (float)model.astar.nodes[model.astar.startNode][1]);
			DrawCircle(start, 0.03f);
		}
		if (model.astar.endNode >= 0)
		{
			Vector2 end = new Vector2((float)model.astar.nodes[model.astar.endNode][0], (float)model.astar.nodes[model.astar.endNode][1]);
			DrawCircle(end, 0.03f);
		}



		//GL.BlendFunc(BlendingFactor.SrcAlpha, BlendingFactor.Zero);
		//GL.Enable(EnableCap.Blend);

		// Draw the map
		GL.LineWidth(1);
		GL.Color4(white);
		GL.Begin(PrimitiveType.Lines);
		foreach (var edge in model.astar.edges)
		{
			GL.Vertex2(model.astar.nodes[(int)edge[0]][0], model.astar.nodes[(int)edge[0]][1]);
			GL.Vertex2(model.astar.nodes[(int)edge[1]][0], model.astar.nodes[(int)edge[1]][1]);
		}
		GL.End();


		if (model.astar.currentPath.Count == 0)
		{
			return;
		}

		if (model.Running == false)
		{
			GL.LineWidth(5);
			DrawPath(model.astar.currentPath, model, red, red);
			return;
		}

		//GL.LineWidth(2);
		foreach (var path in model.astar.WalkedPaths)
		{
			DrawPath(path, model, red, white);
		}
	}


	private void DrawPath(List<int> path, Model model, Vector4 red, Vector4 white)
	{
		float weight = 1.0f;

		GL.Color4(red * weight + white * (1f - weight));
		//GL.LineWidth(1 + weight);

		GL.Begin(PrimitiveType.Lines);
		GL.Vertex2(model.astar.nodes[path.Last()][0], model.astar.nodes[path.Last()][1]);
		for (int i = path.Count - 1; i >= 0; i--)
		{
			weight -= 0.1f;
			if (weight < 0.3f) { weight = 0.3f; }
			//GL.LineWidth(1 + weight);
			GL.Color4(red * weight + white * (1f - weight));

			// If not given 2 times, just every second line is drawn
			GL.Vertex2(model.astar.nodes[path[i]][0], model.astar.nodes[path[i]][1]);
			GL.Vertex2(model.astar.nodes[path[i]][0], model.astar.nodes[path[i]][1]);
		}
		GL.Vertex2(model.astar.nodes[model.astar.startNode][0], model.astar.nodes[model.astar.startNode][1]);
		GL.End();
	}

	private void DrawGrid(IReadOnlyGrid<CellType> grid)
	{
		DrawGridLines(grid.Columns, grid.Rows);
		GL.Color4(Color4.Gray);
		for (int column = 0; column < grid.Columns; ++column)
		{
			for (int row = 0; row < grid.Rows; ++row)
			{
				if (CellType.Circle == grid[column, row])
				{
					DrawCircle(new Vector2(column + 0.5f, row + 0.5f), 0.4f);
				}
			}
		}
	}

	private static void DrawGridLines(int columns, int rows)
	{
		GL.Color4(Color4.White);
		GL.LineWidth(1.0f);
		GL.Begin(PrimitiveType.Lines);
		for (float x = 0; x < columns + 1; ++x)
		{
			GL.Vertex2(x, 0f);
			GL.Vertex2(x, rows);
		}
		for (float y = 0; y < rows + 1; ++y)
		{
			GL.Vertex2(0f, y);
			GL.Vertex2(columns, y);
		}
		GL.End();
	}

	private static List<Vector2> CreateCirclePoints(int corners)
	{
		float delta = 2f * MathF.PI / corners;
		var points = new List<Vector2>();
		for (int i = 0; i < corners; ++i)
		{
			var alpha = i * delta;
			// step around the unit circle
			var x = MathF.Cos(alpha);
			var y = MathF.Sin(alpha);
			points.Add(new Vector2(x, y));
		}
		return points;
	}
}
