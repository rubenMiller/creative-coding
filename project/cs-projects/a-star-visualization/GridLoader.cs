using System;
using System.IO;
using System.Text.Json;
using Zenseless.Spatial;

namespace Example;

internal static class GridLoader
{
	internal static Grid<CellType> CreateGrid()
	{
		// if the file was not found or was of wrong type generate a new grid
		var rnd = new Random();
		var grid = new Grid<CellType>(20, 15);
		for (int x = 0; x < grid.Columns; ++x)
		{
			for (int y = 0; y < grid.Rows; ++y)
			{
				if (7 < rnd.Next(10))
				{
					grid[x, y] = CellType.Circle;
				}
			}
		}
		return grid;
	}

	/// <summary>
	/// Load a grid from a given file. If this fails create a random grid
	/// </summary>
	/// <param name="filePath"></param>
	/// <returns></returns>
	internal static Grid<CellType> FromFile(string filePath)
	{
		try
		{
			var jsonString = File.ReadAllText(filePath);
			var grid = JsonSerializer.Deserialize<Grid<CellType>>(jsonString); // try to load a grid from a file
			if (grid is null) return CreateGrid();
			return grid;
		}
		catch
		{
			return CreateGrid();
		}
	}

	/// <summary>
	/// Save a grid to file
	/// </summary>
	/// <param name="grid">to be saved</param>
	/// <param name="filePath">full path to file for saving the given grid.</param>
	internal static void SaveToFile(this IReadOnlyGrid<CellType> grid, string filePath)
	{
		var jsonString = JsonSerializer.Serialize(grid, new JsonSerializerOptions() { WriteIndented = true });
		File.WriteAllText(filePath, jsonString);
	}
}
