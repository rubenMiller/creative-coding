import time

import pygame

SCREEN_WIDTH = 3000
SCREEN_HEIGHT = 2000


def readGraphFromText():
    with open('coords', 'r') as file:
        lines = file.readlines()

    # https://users.cs.utah.edu/~lifeifei/research/tpq/OL.cnode
    result = []
    for line in lines:
        values = line.split()
        if len(values) == 3:
            result.append([float(values[1])/12, float(values[2])/12])

    #https://users.cs.utah.edu/~lifeifei/research/tpq/OL.cedge
    with open('edges', 'r') as file:
        lines = file.readlines()

    edges = []
    for line in lines:
        values = line.split()
        if len(values) == 4:
            edges.append([int(values[1]), int(values[2]), values[3]])

    return result, edges


def draw(screen, points, edges):
    for e in edges:
        pygame.draw.line(screen, (255, 255, 255), points[e[0]], points[e[1]], 2)

    pygame.display.update()


def main():
    pygame.init()
    screen = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))
    screen.fill((0, 0, 0))

    points, edges = readGraphFromText()
    draw(screen, points, edges)






if __name__ == "__main__":
    main()