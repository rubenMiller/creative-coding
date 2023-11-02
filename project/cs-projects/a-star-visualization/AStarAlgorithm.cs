using System;
using System.Collections.Generic;
using System.Linq;
using System.Numerics;
using System.Runtime.CompilerServices;
using System.Transactions;
using OpenTK.Graphics.ES11;

namespace Example;

public class AStarAlgorithm
{
    PriorityQueue<QueueObject, float> queue = new PriorityQueue<QueueObject, float>(100);
    public List<List<float>> edges;
    public List<List<double>> nodes;
    private List<List<int>> neighbours;
    private List<int> lookedAt = new List<int>();
    public List<int> currentPath;
    public List<List<int>> walkedPaths = new List<List<int>>();
    public int startNode;
    public int endNode;
    public AStarAlgorithm()
    {
        (this.nodes, this.edges) = RoadMapReader.ReadGraphFromText();
        this.neighbours = AStarAlgorithm.MakeNeighbourList(nodes, edges);
        start();
    }

    public void start()
    {
        this.queue.Clear();
        var rand = new Random();
        startNode = rand.Next(nodes.Count);
        endNode = rand.Next(nodes.Count);
        float h = (float)CalculateDistance(nodes[startNode], nodes[endNode]);
        var queueObject = new QueueObject(h, 0, startNode, new List<int> { startNode });
        queue.Enqueue(queueObject, h);
    }

    public List<int> step()
    {
        if (queue.Count < 1)
        {
            return new List<int> { 0 };
        }
        QueueObject current = queue.Dequeue();
        if (current.last_node == endNode)
        {
            // TODO: add behavoir, when this is reached!
            return new List<int> { 1 };
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
        return current.path;
    }

    private static List<int> FindNeighbors(int pIndex, List<List<float>> edgeList)
    {
        List<int> neighbors = new List<int>();

        foreach (var edge in edgeList)
        {
            if (edge.Contains(pIndex))
            {
                int neighborIndex = (int)((edge[0] == pIndex) ? edge[1] : edge[0]);
                neighbors.Add(neighborIndex);
            }
        }

        return neighbors;
    }

    public static List<List<int>> MakeNeighbourList(List<List<double>> points, List<List<float>> edgeList)
    {
        List<List<int>> pointNeighbours = new List<List<int>>();

        for (int index = 0; index < points.Count; index++)
        {
            List<int> neighbors = FindNeighbors(index, edgeList);
            pointNeighbours.Add(neighbors);
        }

        return pointNeighbours;
    }

    public static double CalculateDistance(List<double> point, List<double> goal)
    {
        Vector2 pointVector = new Vector2((float)point[0], (float)point[1]);
        Vector2 goalVector = new Vector2((float)goal[0], (float)goal[1]);
        double distance = Vector2.Distance(pointVector, goalVector);

        return distance;
    }
}