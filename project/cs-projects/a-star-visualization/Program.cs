using Example;
using Framework;
using OpenTK.Windowing.Desktop;
using System.Reflection;

string levelFile = Assembly.GetExecutingAssembly().Location + ".level.json";
GameWindow window = ExampleWindow.Create();


Model model = new();
View view = new();
Controller controller = new(model, view);

//window.MouseDown += args => controller.Click(window.MousePosition);
window.UpdateFrame += args =>
{
	controller.Update((float)args.Time, window.KeyboardState, window.MouseState);
	model.Update((float)args.Time);
}; // call update once each frame

window.Resize += args => view.Resize(args.Width, args.Height); // on window resize let the view do whats needs to be done
window.RenderFrame += _ => view.Draw(model); // first draw the model
window.RenderFrame += _ => window.SwapBuffers(); // then wait for next frame and buffer swap

window.Run(); // start the game loop

