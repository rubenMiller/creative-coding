using OpenTK.Mathematics;
using OpenTK.Windowing.Common;
using OpenTK.Windowing.Desktop;
using OpenTK.Windowing.GraphicsLibraryFramework;
using System.Reflection;

namespace Framework;

public static class ExampleWindow
{
	public static GameWindow Create()
	{
		// window with immediate mode rendering enabled
		var window = new GameWindow(GameWindowSettings.Default, new NativeWindowSettings { Profile = ContextProfile.Compatability });
		// set window to halve monitor size
		var info = Monitors.GetMonitorFromWindow(window);
		window.Size = new Vector2i(info.HorizontalResolution, info.VerticalResolution) / 2;
		window.VSync = VSyncMode.On;
#if SOLUTION
		window.Title = Assembly.GetEntryAssembly()?.GetName().Name;
		//for easy screen capture
		//window.WindowState = WindowState.Normal;
		//window.WindowBorder = WindowBorder.Hidden;
		//window.Bounds = new Rectangle(200, 20, 1024, 1024);
		window.KeyDown += args =>
		{
			if (Keys.Escape == args.Key)
			{
				window.Close();
			}
		};
#endif
		return window;
	}
}
