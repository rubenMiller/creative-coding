using System.Collections.Generic;
using Zenseless.Spatial;

namespace Example;


internal class Model
{
	public AStarAlgorithm astar = new AStarAlgorithm();
	public Model()
	{

	}

	internal void Update(float frameTime)
	{
		astar.step();
	}

}
