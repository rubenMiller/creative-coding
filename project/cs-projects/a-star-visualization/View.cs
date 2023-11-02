using OpenTK.Graphics.OpenGL;
using OpenTK.Mathematics;
using System;
using System.Collections.Generic;
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
		GL.Color4(Color4.Red);
		Vector2 start = new Vector2((float)model.astar.nodes[model.astar.startNode][0], (float)model.astar.nodes[model.astar.startNode][1]);
		Vector2 end = new Vector2((float)model.astar.nodes[model.astar.endNode][0], (float)model.astar.nodes[model.astar.endNode][1]);
		DrawCircle(start, 0.01f);
		DrawCircle(end, 0.01f);

		GL.LineWidth(1);
		GL.Color4(Color4.White);
		GL.Begin(PrimitiveType.Lines);
		foreach (var edge in model.astar.edges)
		{
			GL.Vertex2(model.astar.nodes[(int)edge[0]][0], model.astar.nodes[(int)edge[0]][1]);
			GL.Vertex2(model.astar.nodes[(int)edge[1]][0], model.astar.nodes[(int)edge[1]][1]);
		}
		GL.End();


		GL.LineWidth(1);
		GL.Color4(Color4.Gray);

		foreach (var path in model.astar.walkedPaths)
		{
			GL.Begin(PrimitiveType.Lines);
			foreach (var point in path)
			{
				GL.Vertex2(model.astar.nodes[point][0], model.astar.nodes[point][1]);
			}
			GL.End();
		}


		GL.LineWidth(3);
		GL.Color4(Color4.Red);
		GL.Begin(PrimitiveType.Lines);
		foreach (var point in model.astar.currentPath)
		{
			GL.Vertex2(model.astar.nodes[point][0], model.astar.nodes[point][1]);
		}
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

	/// <summary>
	/// Calculates points on a circle.
	/// </summary>
	/// <returns></returns>
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
