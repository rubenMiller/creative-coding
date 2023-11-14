using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using OpenTK.Graphics.OpenGL;

namespace Example;

public class RoadMapReader
{
    public static (List<List<double>> nodes, List<List<float>> edges, List<List<int>> neighbors) ReadGraphFromText()
    {
        List<List<double>> points = new List<List<double>>();
        List<List<float>> edges = new List<List<float>>();
        List<List<int>> neighbours = new List<List<int>>();

        string Folder = "data/SanFrancisco/";

        string pointsPath = Folder + "coords";
        string edgePath = Folder + "edges";
        string neigbhoursPath = Folder + "neighbours";

        double min_x = 10000;
        double max_x = 0;
        double min_y = 10000;
        double max_y = 0;

        // Read nodes from 'coords' file
        using (StreamReader nodeFile = new StreamReader(pointsPath))
        {
            string line;
            while ((line = nodeFile.ReadLine()) != null)
            {
                string[] values = line.Split();
                if (values.Length == 3)
                {
                    double x = double.Parse(values[1]);
                    double y = double.Parse(values[2]);
                    points.Add(new List<double> { x, y });

                    if (x > max_x)
                    {
                        max_x = x;
                    }
                    if (x < min_x)
                    {
                        min_x = x;
                    }
                    if (y > max_y)
                    {
                        max_y = y;
                    }
                    if (y < min_y)
                    {
                        min_y = y;
                    }
                }
            }
        }

        // changing the points to fit the openTK map from 1 to 1
        foreach (var point in points)
        {
            double x = point[0];
            double y = point[1];

            x -= (max_x - min_x) / 2;
            y -= (max_y - min_y) / 2;

            x = (16 * x) / (max_x - min_x);
            y = (16 * y) / (max_y - min_y);

            point[0] = x;
            point[1] = y;
        }

        // Read edges from 'edges' file
        using (StreamReader edgeFile = new StreamReader(edgePath))
        {
            string line;
            while ((line = edgeFile.ReadLine()) != null)
            {
                string[] values = line.Split();
                if (values.Length == 4)
                {
                    int sourceNode = int.Parse(values[1]);
                    int targetNode = int.Parse(values[2]);
                    float edgeLabel = float.Parse(values[3], CultureInfo.InvariantCulture.NumberFormat);
                    edges.Add(new List<float> { sourceNode, targetNode, edgeLabel });
                }
            }
        }


        try
        {
            using (StreamReader neighbourFile = new StreamReader(neigbhoursPath))
            {
                string line;
                while ((line = neighbourFile.ReadLine()) != null)
                {
                    string[] values = line.Split(" ");
                    List<int> inner = new List<int>();

                    foreach (string str in values)
                    {
                        inner.Add(int.Parse(str));
                    }
                    neighbours.Add(inner);
                }
            }


        }
        catch (FileNotFoundException ex)
        {
            neighbours = MakeNeighbourList(points, edges);


            using (StreamWriter writer = new StreamWriter(neigbhoursPath))
            {
                for (int i = 0; i < neighbours.Count; i++)
                {
                    List<int> line = neighbours[i];

                    // Join the integers in the inner list with spaces
                    string lineText = string.Join(" ", line);

                    // Write the line to the file
                    writer.WriteLine(lineText);
                }
            }

        }

        return (points, edges, neighbours);
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
            //Console.WriteLine("At: " + index + " from: " + points.Count);
        }

        return pointNeighbours;
    }
}
