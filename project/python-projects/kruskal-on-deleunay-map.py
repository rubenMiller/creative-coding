import pygame
import math
import time

from kruskal import Graph

from delaunay import create_delanauy_mesh, create_edge_list

SCREEN_WIDTH = 1000
SCREEN_HEIGHT = 1000




def create_graph(edges, points):
    g = Graph(len(points))
    for edge in edges:
        w = math.dist(points[edge[0]], points[edge[1]])
        g.addEdge(edge[0], edge[1], w)
    return g


def drawOnce(screen, points, edges):
    for p in points:
        pygame.draw.circle(screen, (255, 0, 0), p, 5)

    for e in edges:
        pygame.draw.line(screen, (255, 255, 255), points[e[0]], points[e[1]], 3)

    pygame.display.update()


def drawLoop(screen, elapsedTime, mst, points):
    max = int(elapsedTime/60 - 1)
    if max < 0:
        max = 0
    if max > len(mst):
        max = len(mst)
        return False

    for m in range(max):
        start = mst[m][0]
        end = mst[m][1]
        #print("Draw line between, ", start, " , ", end)
        pygame.draw.line(screen, (255, 0, 0), points[start], points[end], 6)

    pygame.display.update()

    return True

def loop(screen, startTime):
    dela, points = create_delanauy_mesh()
    edge_list = create_edge_list(dela)
    g = create_graph(edge_list, points)
    mst = g.KruskalMST()
    drawOnce(screen, points, edge_list)
    run = True
    while(run):
        elapsedTime = int(round(time.time() * 1000)) - startTime
        run = drawLoop(screen, elapsedTime, mst, points)

    time.sleep(10)




def main():
    pygame.init()

    screen = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))

    while (True):
        screen.fill((0, 0, 0))
        starttime = int(round(time.time() * 1000))
        loop(screen, starttime)


if __name__ == "__main__":
    main()
