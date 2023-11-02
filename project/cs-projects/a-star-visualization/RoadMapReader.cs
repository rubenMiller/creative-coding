using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Security.Cryptography.X509Certificates;

namespace Example;

public class RoadMapReader
{
    public static (List<List<double>> nodes, List<List<float>> edges) ReadGraphFromText()
    {
        List<List<double>> points = new List<List<double>>();
        List<List<float>> edges = new List<List<float>>();

        double min_x = 10000;
        double max_x = 0;
        double min_y = 10000;
        double max_y = 0;

        // Read nodes from 'coords' file
        using (StreamReader nodeFile = new StreamReader("data-2/coords"))
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
        using (StreamReader edgeFile = new StreamReader("data-2/edges"))
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

        return (points, edges);
    }
}
