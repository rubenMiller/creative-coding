#https://medium.com/nerd-for-tech/graph-traversal-in-python-a-algorithm-27c30d67e0d0
#https://networkx.guide/algorithms/shortest-path/a-star-search/#:~:text=Using%20A*%20search%20algorithm%20in,geometrical%20distances%20between%20the%20points.&text=The%20first%20output%20represents%20the,point%20(2%2C2).
import math
from random import random
import heapq

import pygame


from delaunay import create_delanauy_mesh, create_edge_list
from road_graph import readGraphFromText
import time

SCREEN_WIDTH = 1000
SCREEN_HEIGHT = 1000

class path:
    path = []
    weight = 0

    def __init__(self, start, end):
        self.start = start
        self.end = end


class Window:
    width = SCREEN_WIDTH/2
    height = SCREEN_HEIGHT/2

    def __init__(self, X, Y):
        self.x = X
        self.y = Y

def calculate_distance(point, goal):
    return math.dist([point[0], point[1]], [goal[0], goal[1]])

def find_neighbors(pindex, edge_list):
    neighbours = []
    for e in edge_list:
        if pindex in e:
            if int(e[0]) == (pindex):
                neighbours.append(e[1])
            else:
                neighbours.append(e[0])

    return neighbours


def make_neighbour_list(points, edge_list):
    point_neighbours = []
    for index, p in enumerate(points):
        neighbours = find_neighbors(index, edge_list)
        point_neighbours.append(neighbours)

    return point_neighbours

def a_star(screen, points, edge_list, neighbours):
    start = int(random() * len(points))
    end = int(random() * len(points))
    dist = calculate_distance(points[start], points[end])

    heap = []
    heapq.heapify(heap)
    # will sort by the first element of the tuple
    heapq.heappush(heap, (dist, start, 0, [start]))
    cpath = []
    drawOnce(screen, points, edge_list, start, end)
    looked_at = []

    while len(heap) > 0:
        heuristic, current_node, distance, cpath = heapq.heappop(heap)
        if len(cpath) > 2:
            draw_line_between_points(screen, points[cpath[-2]], points[cpath[-1]], 2)
        if current_node == end:
            break
        for n in neighbours[current_node]:
            if n in cpath or n in looked_at:
                continue
            looked_at.append(n)
            walked_path = distance + calculate_distance(points[n], points[current_node])
            heuristic = walked_path + calculate_distance(points[n], points[end])
            heapq.heappush(heap, (heuristic, n, walked_path,  cpath+[n]))

        time.sleep(0.002)
        #screen.blit(window, (0, 0))
        #pygame.display.flip()


    print("SUCCESS!")
    drawPath(screen, cpath, points, 5)

    #screen.blit(window, (0, 0))
    pygame.display.flip()

    for i in range(20):
        time.sleep(0.1)


def draw_line_between_points(screen, point_1, point_2, wheight):
    pygame.draw.line(screen, (127, 127, 127), point_1, point_2, wheight)
    #screen.
    pygame.display.update(point_1, point_2)


def drawPath(screen, path, points, weight):
    # This is by far the most cpu intensive Function :(
    # But without this no looky-looky 
    first = path[0]
    for p in path:
        pygame.draw.line(screen, (0, 220, 0), points[first], points[p], weight)
        first = p

    pygame.display.flip()


def drawOnce(screen, points, edges, start, end):

    pygame.draw.circle(screen, (255, 0, 0), points[start], 20)
    pygame.draw.circle(screen, (255, 0, 0), points[end], 20)

    for e in edges:
        pygame.draw.line(screen, (255, 255, 255), points[e[0]], points[e[1]], 2)

    #pygame.font.init()
    #my_font = pygame.font.SysFont('Comic Sans MS', 30)

    #for counter,  p in enumerate(points):
    #    text_surface = my_font.render(str(counter), False, (255, 0, 0))
    #    screen.blit(text_surface, (p[0], p[1]))
    pygame.display.update()



def main():
    pygame.init()
    screen = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))
    screen.fill((0, 0, 0))
    #window = pygame.Surface((SCREEN_WIDTH, SCREEN_HEIGHT))

    points, edge_list = readGraphFromText()
    neighbours = make_neighbour_list(points, edge_list)
    while(True):
        screen.fill((0, 0, 0))
        a_star(screen, points, edge_list, neighbours)


if __name__ == "__main__":
    main()