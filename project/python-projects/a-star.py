#https://medium.com/nerd-for-tech/graph-traversal-in-python-a-algorithm-27c30d67e0d0
#https://networkx.guide/algorithms/shortest-path/a-star-search/#:~:text=Using%20A*%20search%20algorithm%20in,geometrical%20distances%20between%20the%20points.&text=The%20first%20output%20represents%20the,point%20(2%2C2).
import math

import pygame

from delaunay import create_delanauy_mesh, create_edge_list
import time
SCREEN_WIDTH = 1000
SCREEN_HEIGHT = 1000

class path:
    path = []
    weight = 0

    def __init__(self, start, end):
        self.start = start
        self.end = end



def calculate_distance(point, goal):
    return math.dist([point[0], point[1]], [goal[0], goal[1]])

def find_neighbors(pindex, triang):

    return triang.vertex_neighbor_vertices[1][triang.vertex_neighbor_vertices[0][pindex]:triang.vertex_neighbor_vertices[0][pindex+1]]
def a_star(screen):

    dela, points = create_delanauy_mesh(SCREEN_WIDTH, SCREEN_HEIGHT, 800)
    edge_list = create_edge_list(dela)
    start = 0
    end = len(points)-1
    dist = calculate_distance(points[start], points[end])
    queue = [(start, 0, dist, dist, [start])]
    cpath = []
    drawOnce(screen, points, edge_list)
    while len(queue) > 0:
        current_node, distance, h, combined, cpath = queue.pop(0)
        print("Path: ", cpath, " has length: ", distance, "h: ", h, " combined: ", combined)
        if current_node == end:
            break
        neighbours = find_neighbors(current_node, dela)
        next_objects = []
        for n in neighbours:
            if n in cpath:
                continue
            h = calculate_distance(points[n], points[end])
            w = calculate_distance(points[n], points[current_node])
            walked_path = w + distance
            combined = h + walked_path
            next_objects.append((n, walked_path, h, combined, cpath+[n]))


        queue.extend(next_objects)
        queue.sort(key=lambda x: x[3])



        drawPath(screen, cpath[-2:], points, 2)
        #time.sleep(.3)

    drawPath(screen, cpath, points, 6)
    time.sleep(5)


def drawPath(screen, path, points, weight):
    first = path[0]
    for p in path:
        pygame.draw.line(screen, (0, 255, 0), points[first], points[p], weight)
        first = p

        pygame.display.update()


def drawOnce(screen, points, edges):

    pygame.draw.circle(screen, (255, 0, 0), points[0], 10)
    pygame.draw.circle(screen, (255, 0, 0), points[-1], 10)

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
    while(True):
        screen.fill((0, 0, 0))
        a_star(screen)


if __name__ == "__main__":
    main()