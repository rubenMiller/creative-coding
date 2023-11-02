import time

import pygame
from random import random

import numpy as np
from scipy.spatial import Delaunay

SCREEN_WIDTH = 1000
SCREEN_HEIGHT = 1000


def make_point(width, height):
    return [int(random() * width), int(random() * height)]


def loop(screen):

    dela, points = create_delanauy_mesh(SCREEN_WIDTH, SCREEN_HEIGHT, 300)
    edge_list = create_edge_list(dela)

    for edge in edge_list:
        print("drawing edge: ", edge, " at: ", points[edge[0]], " , ", points[edge[1]])
        pygame.draw.line(screen, (255, 255, 255), points[edge[0]], points[edge[1]], 5)

    pygame.display.update()
    time.sleep(5)


def create_delanauy_mesh(w, h, nop):
    points = create_points(w, h, nop)
    dela = Delaunay(points)

    return dela, points

def create_edge_list(dela):
    edges = set()
    for simplex in dela.simplices:
        edges.update({(simplex[0], simplex[1]), (simplex[1], simplex[2]), (simplex[0], simplex[2])})
    # Convert the set of edges to a list
    edge_list = list(edges)
    return edge_list


def create_points(w, h, number_of_points):
    points = np.empty((0, 2))
    for i in range(number_of_points):
        p = make_point(w, h)
        points = np.append(points, [p], axis=0)
        # pygame.draw.circle(screen, (255, 0, 0), (p[0], p[1]), 10)
    return points


def main():
    pygame.init()

    screen = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))

    while (True):
        screen.fill((0, 0, 0))
        loop(screen)





if __name__ == "__main__":
    main()
