using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Transactions;
using OpenTK.Graphics.ES11;
using OpenTK.Graphics.ES20;
using OpenTK.Mathematics;
using OpenTK.Windowing.Common;
using OpenTK.Windowing.GraphicsLibraryFramework;

namespace Example;

internal class AStarAlgorithm
{
    PriorityQueue<QueueObject, float> queue = new PriorityQueue<QueueObject, float>(100);
    public List<List<float>> edges;
    public List<List<double>> nodes;
    private List<List<int>> neighbours;
    private List<int> lookedAt = new List<int>();
    public List<int> currentPath = new List<int>();
    public List<List<int>> walkedPaths = new List<List<int>>();
    public int startNode = -1;
    public int endNode = -1;
    public bool ResetAble = true;
    private bool readToRun = true;
    public AStarAlgorithm()
    {
        (this.nodes, this.edges, this.neighbours) = RoadMapReader.ReadGraphFromText();
        //start();
    }


    public bool Ready()
    {
        if (startNode >= 0 && endNode >= 0 && readToRun)
        {
            return true;
        }
        return false;
    }

    public void Reset()
    {
        this.queue.Clear();
        this.lookedAt.Clear();
        this.currentPath.Clear();
        this.walkedPaths.Clear();
        startNode = -1;
        endNode = -1;
        ResetAble = false;
        readToRun = true;
    }

    public void Start()
    {
        float h = (float)CalculateDistance(nodes[startNode], nodes[endNode]);
        var queueObject = new QueueObject(h, 0, startNode, new List<int> { startNode });
        queue.Enqueue(queueObject, h);


    }
    public void SetPath(KeyboardState keyboard, MouseState mouseState, Controller controller)
    {
        var rand = new Random();
        if (keyboard.IsKeyDown(Keys.R))
        {
            Console.WriteLine("R");
            startNode = rand.Next(nodes.Count);
            endNode = rand.Next(nodes.Count);
        }
        else if (mouseState.IsButtonPressed(MouseButton.Left))
        {
            // Transform the pixel coordinates into world
            var world = controller.transformIntoWorld(mouseState.Position);
            //TODO: this does not work the right way, positions seem to be wrong
            if (startNode == -1)
            {
                startNode = findNearestNeighbour(world);
            }
            else if (endNode == -1)
            {
                endNode = findNearestNeighbour(world);
            }
        }
    }


    private int findNearestNeighbour(Vector2 position)
    {
        int currentNN = 0;
        float currentDist = 10000000;
        for (int i = 0; i < nodes.Count; i++)
        {
            List<double> list = new List<double> { (double)position.X, (double)position.Y };
            float dist = (float)CalculateDistance(nodes[i], list);
            if (dist < currentDist)
            {
                currentDist = dist;
                currentNN = i;
            }
        }

        return currentNN;
    }

    public bool step()
    {
        if (queue.Count < 1)
        {
            readToRun = false;
            return false;
        }
        QueueObject current = queue.Dequeue();
        if (current.last_node == endNode)
        {
            readToRun = false;
            this.currentPath = current.path;
            return false;
        }

        foreach (var n in neighbours[current.last_node])
        {
            if (current.path.Contains(n) || lookedAt.Contains(n))
            {
                continue;
            }
            lookedAt.Add(n);
            float walkedPath = current.walkedDistance + (float)CalculateDistance(nodes[n], nodes[current.last_node]);
            float h = (float)(walkedPath + CalculateDistance(nodes[n], nodes[endNode]));
            var path = current.path.Concat(new[] { n }).ToList();
            var queueObj = new QueueObject(h, walkedPath, n, path);
            queue.Enqueue(queueObj, h);
        }

        this.currentPath = current.path;
        walkedPaths.Add(current.path);
        return true;
    }



    public static double CalculateDistance(List<double> point, List<double> goal)
    {
        Vector2 pointVector = new Vector2((float)point[0], (float)point[1]);
        Vector2 goalVector = new Vector2((float)goal[0], (float)goal[1]);
        double distance = Vector2.Distance(pointVector, goalVector);

        return distance;
    }
}