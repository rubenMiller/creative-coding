// The Flock (a list of Boid objects)

class Flock {
  ArrayList<Boid> boids; // An ArrayList for all the boids

  Flock() {
    boids = new ArrayList<Boid>(); // Initialize the ArrayList
  }

  void run(int[][] map) {
    for (Boid b : boids) {
      b.run(boids, map);  // Passing the entire list of boids to each boid individually

    }
  }

  void addBoid(Boid b) {
    boids.add(b);
  }

}
