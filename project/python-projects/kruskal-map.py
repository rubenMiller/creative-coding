import math
import time
from random import random
from typing import List, Any

import pygame

from os import system


class Point:

    def __init__(self):
        self.x = int(random() * 1000)
        self.y = int(random() * 1000)


# From here: https://www.geeksforgeeks.org/kruskals-minimum-spanning-tree-algorithm-greedy-algo-2/
class Graph:

    def __init__(self, vertices):
        self.V = vertices
        self.graph = []

        # Function to add an edge to graph

    def addEdge(self, u, v, w):
        self.graph.append([u, v, w])

        # A utility function to find set of an element i

    # (truly uses path compression technique)
    def find(self, parent, i):
        if parent[i] != i:
            # Reassignment of node's parent
            # to root node as
            # path compression requires
            parent[i] = self.find(parent, parent[i])
        return parent[i]

        # A function that does union of two sets of x and y

    # (uses union by rank)
    def union(self, parent, rank, x, y):

        # Attach smaller rank tree under root of
        # high rank tree (Union by Rank)
        if rank[x] < rank[y]:
            parent[x] = y
        elif rank[x] > rank[y]:
            parent[y] = x

            # If ranks are same, then make one as root
        # and increment its rank by one
        else:
            parent[y] = x
            rank[x] += 1

    # The main function to construct MST
    # using Kruskal's algorithm
    def KruskalMST(self):

        # This will store the resultant MST
        result: List[List[Any]] = []

        # An index variable, used for sorted edges
        i = 0

        # An index variable, used for result[]
        e = 0

        # Sort all the edges in
        # non-decreasing order of their
        # weight
        self.graph = sorted(self.graph,
                            key=lambda item: item[2])

        parent = []
        rank = []

        # Create V subsets with single elements
        for node in range(self.V):
            parent.append(node)
            rank.append(0)

            # Number of edges to be taken is less than to V-1
        while e < self.V - 1:

            # Pick the smallest edge and increment
            # the index for next iteration
            u, v, w = self.graph[i]
            i = i + 1
            x = self.find(parent, u)
            y = self.find(parent, v)

            # If including this edge doesn't
            # cause cycle, then include it in result
            # and increment the index of result
            # for next edge
            if x != y:
                e = e + 1
                result.append([u, v, w])
                self.union(parent, rank, x, y)
                # Else discard the edge

        minimumCost = 0
        print("Edges in the constructed MST")
        for u, v, weight in result:
            minimumCost += weight
            print("%d -- %d == %d" % (u, v, weight))
        print("Minimum Spanning Tree", minimumCost)

        return result

    # Driver code


def drawLoop(mst: List[List[Any]], points, startTime: float, screen, elapsedTime):
    white = (255, 255, 255)
    blue = (0, 0, 255)
    green = (0, 255, 0)
    #m = int(startTime / 33)
    #if len(mst) < m:
    #    return
    max = int(elapsedTime/30 - 1)
    if max < 0:
        max = 0
    if max > len(mst):
        max = len(mst)
        time.sleep(2)
        return False

    for m in range(max):
        start = mst[m][0]
        end = mst[m][1]
        #print("Draw line between, ", start, " , ", end)
        p1 = [points[start].x, points[start].y]
        p2 = [points[end].x, points[end].y]
        pygame.draw.line(screen, white, p1, p2, 5)

    pygame.display.update()
    return True

def loop(screen):
    points = []

    for i in range(300):
        p = Point()
        points.append(p)
        #pygame.draw.circle(screen, (255, 0, 0), (p.x, p.y), 10)

    g = Graph(len(points))
    for i in range(len(points)):
        for j in range(i, len(points)):
            if j == i:
                continue
            w = math.dist([points[i].x, points[i].y], [points[j].x, points[j].y])
            g.addEdge(i, j, w)

    # g.addEdge(0, 1, 10)
    # g.addEdge(0, 2, 6)
    # g.addEdge(0, 3, 5)
    # g.addEdge(1, 3, 15)
    # g.addEdge(2, 3, 4)



    # Function call
    mst = g.KruskalMST()
    print("Starting gameLoop")
    run = True
    startTime = int(round(time.time() * 1000))
    while(run):
        elapsedTime = int(round(time.time() * 1000)) - startTime
        print(elapsedTime)
        run = drawLoop(mst, points, 0, screen, elapsedTime)

    return

def main():

    pygame.init()

    screen_width = 1000
    screen_height = 1000

    screen = pygame.display.set_mode((screen_width, screen_height))

    while(True):
        loop(screen)
        screen.fill((0, 0, 0))


if __name__ == "__main__":
    main()
