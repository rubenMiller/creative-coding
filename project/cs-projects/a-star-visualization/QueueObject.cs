using System.Collections.Generic;

internal class QueueObject
{
    public float heuristic;
    public float walkedDistance;
    public int last_node;
    public List<int> path = new List<int>();
    public QueueObject(float heuristic, float walkedDistance, int last_node, List<int> path)
    {
        this.heuristic = heuristic;
        this.walkedDistance = walkedDistance;
        this.last_node = last_node;
        this.path = path;
    }
}