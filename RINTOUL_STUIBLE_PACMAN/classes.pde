class Sprite {
	float x;
	float y;
	float dx;
	float dy;

	void update() {
		x += dx;
		y += dy;
	}
}

class Pacman extends Sprite {
	float radius;
	float spritePrevLocationX;
	float spritePrevLocationY;
	float mouthWide;
	boolean mouthClosing;
	float rotation;

	void moveMouth(){
		if (mouthWide > 20) {
			mouthClosing = true;
		}
		if (mouthWide > 0 && mouthClosing == true) {
			mouthWide -= 1;
		}
		else if (mouthWide > 0 && mouthClosing == false) {
			mouthWide += 1;
		}
		if (mouthWide <= 0 && mouthClosing == true) {
			mouthClosing = false;
			mouthWide += 1;
		}
		else if (mouthWide <= 0 && mouthClosing == false) {
			mouthClosing = true;
			mouthWide += 1;
		}


	}

	void detectCollision() {
		//Check edges of window
		if (pacman.x - pacman.radius < 0 
			|| pacman.x + pacman.radius> width 
			|| pacman.y - pacman.radius < 0 
			|| pacman.y + pacman.radius > height) {
			clearMotion();
			pacman.x = pacman.spritePrevLocationX;
			pacman.y = pacman.spritePrevLocationY;
		}

		//Pacman collision detection
		for (Wall wall : wallList) {
			if ((pacman.x + pacman.radius > wall.x)
				&& (pacman.x - pacman.radius < wall.x + wall.w) 
				&& (pacman.y + pacman.radius > wall.y) 
				&& (pacman.y - pacman.radius < wall.y + wall.h)) {
				pacman.x = pacman.spritePrevLocationX;
				pacman.y = pacman.spritePrevLocationY;
				clearMotion();
			}
		}
	}
}

class Wall extends Sprite{
  float w;
  float h;

  void render() {
  	fill(0);
  	stroke(0, 0, 255);
  	strokeWeight(2);
  	rect(x, y, w, h);
  	noStroke();
  }
}

class Pellet extends Sprite {
	float pfill = 255;
	boolean touchedbyPacman = false;

	void render() {
		fill(pfill);
		rect(x, y, 5, 5);
	}

	void detectCollision() {
		if (dist(pacman.x, pacman.y, x, y) < pacman.radius){
			pfill = 0;
			if (touchedbyPacman == false) {
				score += 1;
				touchedbyPacman = true;
			}
		}
	}
}

class Ghost extends Sprite {
	float w;
	float h;
	float speed;

	float spritePrevLocationX;
	float spritePrevLocationY;

	void update() {
		x += dx;
		y += dy;
	}

	void detectCollision() {
		//Check edges of window
		if (x + w > width 
			|| x < 0 
			|| y + h > height 
			|| y < 0) {
			if (dx > 0 || dx < 0) {
					int randomDir = int(random(0, 2));
					if (randomDir == 0) {
						dx = 0;
						dy = speed;
					}
					else {
						dx = 0;
						dy = speed * -1;
					}
					
				}
				else if (dy > 0 || dy < 0) {
					int randomDir = int(random(0, 2));
					if (randomDir == 0) {
						dx = speed;
						dy = 0;
					}
					else {
						dx = speed * -1;
						dy = 0;
					}
					
				}
			x = spritePrevLocationX;
			y = spritePrevLocationY;
			dx = dx * -1;
			dy = dy * -1;
			println("hit edge");
		}

		for (Wall wall : wallList) {
			if ((x  + w > wall.x)
				&& (x < wall.x + wall.w) 
				&& (y  + h > wall.y) 
				&& (y < wall.y + wall.h)) {
				if (dx > 0 || dx < 0) {
					int randomDir = int(random(0, 2));
					if (randomDir == 0) {
						dx = 0;
						dy = speed;
					}
					else {
						dx = 0;
						dy = speed * -1;
					}
					
				}
				else if (dy > 0 || dy < 0) {
					int randomDir = int(random(0, 2));
					if (randomDir == 0) {
						dx = speed;
						dy = 0;
					}
					else {
						dx = speed * -1;
						dy = 0;
					}
					
				}
				x = spritePrevLocationX;
				y = spritePrevLocationY;
				dx = dx * -1;
				dy = dy * -1;
				println("hit wall");
			}
		}

		if (dist(pacman.x, pacman.y, x + 25, y + 25) < pacman.radius + 25){
			lives -= 1;
			setGame();
		}
	}
}

class Particle extends Sprite{
	float x = mouseX;
	float y = mouseY;

	void randomRestart() {
		x = mouseX;
		y = mouseY;
		dx = random(-3, 3);
		dy = random(-3, 3);
	}

	void render() {
		fill(yellow);
		ellipse(x, y, 5, 5);
	}

	void update() {
		x += dx;
		y += dy;

		if (offScreen()) {
			randomRestart();
		}
	}

	boolean offScreen() {
		if (y > height || y < 0 || x > width || x < 0) {
			return true;
		} else {
			return false;
		}
	}
}