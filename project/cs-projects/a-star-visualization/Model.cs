using System.Collections.Generic;
using System.Linq.Expressions;
using OpenTK.Windowing.GraphicsLibraryFramework;
using Zenseless.Spatial;

namespace Example;


internal class Model
{
	public AStarAlgorithm astar = new AStarAlgorithm();
	private bool _running = false;
	public bool Running { get { return _running; } private set { _running = value; } }
	private float downTime = 2;
	private float maxDownTime = 2;
	public Model()
	{

	}

	internal void Update(float frameTime, KeyboardState keyboard, MouseState mouseState, Controller controller)
	{


		if (_running == false)
		{
			if (!astar.Ready())
			{
				astar.SetPath(keyboard, mouseState, controller);
			}
			downTime += frameTime;

			if (downTime > maxDownTime && astar.ResetAble && keyboard.IsKeyPressed(Keys.C))
			//if (downTime > maxDownTime && astar.ResetAble)
			{
				astar.Reset();
			}

			if (downTime > maxDownTime && astar.Ready())
			{
				downTime = 0;
				astar.Start();
				_running = true;
			}
		}

		//makes multiple steps per update, this means faster a star at the cost of framerate
		if( _running == true)
		{
			_running = astar.Update();
			astar.ResetAble = true;
		}



	}

}
