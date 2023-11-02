using System.Collections.Generic;
using Zenseless.Spatial;

namespace Example;


internal class Model
{
	public AStarAlgorithm astar = new AStarAlgorithm();
	private bool running = true;
	private float downTime = 0;
	private float maxDownTime = 5;
	public Model()
	{

	}

	internal void Update(float frameTime)
	{
		if (running == true)
		{
			running = astar.step();
		}
		else
		{
			downTime += frameTime;
			if (downTime > maxDownTime)
			{
				downTime = 0;
				running = true;
				astar.start();
			}
		}

	}

}
