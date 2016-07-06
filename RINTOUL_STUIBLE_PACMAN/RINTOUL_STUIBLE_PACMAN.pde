//CMPT 166
//Project 4
//Macguire Rintoul - 301258009
//Joshua Stuible - 301263641

Pacman pacman = new Pacman();
Ghost ghost1 = new Ghost();
Ghost ghost2 = new Ghost();
Ghost ghost3 = new Ghost();
Sprite introSprite = new Sprite();
Pellet pellet = new Pellet();
ArrayList<Wall> wallList;
ArrayList<Pellet> pelletList;
ArrayList<Particle> particleList;

//Global variables
int NUM_DROPLETS = 40;
int pix = 25;
int score = 0;
color playButtonColour = color(255);
color yellow = color(255, 255, 0);
color purple = color(255, 0, 255);
boolean started = false;
boolean firstRun = true;
PImage pacmanlogo;
PImage introImage;
PImage pinkyGhost;
PImage blinkyGhost;
PImage inkyGhost;
PFont vcrfont;
PFont ostrichSansfont;
int lives = 3;

Wall mazeWall(float x, float y, float w, float h) {
	Wall wall = new Wall();
	wall.x = x * pix;
	wall.y = y * pix;
	wall.w = w * pix;
	wall.h = h * pix;
	return wall;
}

Pellet pellet(float x, float y) {
	Pellet pellet = new Pellet();
	pellet.x = x * pix;
	pellet.y = y * pix;
	return pellet;
}

void setGame() {
	//Setup for intro sprite
	introImage = loadImage("introImage.jpg");
	introSprite.x = 0;
	introSprite.y = height - height / 3;
	introSprite.dx = 2;
	introSprite.dy = 0;

	pacman.radius = pix - 5;
	pacman.x = pacman.radius;
	pacman.y = pacman.radius;
	pacman.dx = 0;
	pacman.dy = 0;
	pacman.mouthWide = 20;
	pacman.mouthClosing = true;
	pacman.rotation = 0;

	ghost1.x = 13 * pix - 6;
	ghost1.y = 16 * pix + 6;
	ghost1.spritePrevLocationX = ghost1.x;
	ghost1.spritePrevLocationY = ghost1.y;
	ghost1.w = 40;
	ghost1.h = 40;
	ghost1.speed = 1;
	ghost1.dx = 1;
	ghost1.dy = 0;

	ghost2.x = 13 * pix - 6;
	ghost2.y = 16 * pix + 6;
	ghost2.spritePrevLocationX = ghost2.x;
	ghost2.spritePrevLocationY = ghost2.y;
	ghost2.w = 40;
	ghost2.h = 40;
	ghost2.speed = 1;
	ghost2.dx = -1;
	ghost2.dy = 0;

	ghost3.x = 13 * pix - 6;
	ghost3.y = 16 * pix + 6;
	ghost3.spritePrevLocationX = ghost3.x;
	ghost3.spritePrevLocationY = ghost3.y;
	ghost3.w = 40;
	ghost3.h = 40;
	ghost3.speed = 2;
	ghost3.dx = 2;
	ghost3.dy = 0;
}

void setup() {
	//size(27 * pix, 30 * pix);
  size(670, 750);
	ellipseMode(RADIUS);
	smooth();
	
	//Text
	vcrfont = loadFont("VCROSDMono-60.vlw");
    ostrichSansfont = loadFont("OstrichSans-Black-48.vlw");
	pinkyGhost = loadImage("Pinkyyghost.png");
	inkyGhost = loadImage("inky.png");
	blinkyGhost = loadImage("blinky.png");
	textFont(vcrfont, 30);
	textAlign(LEFT, CENTER);

	wallList = new ArrayList<Wall>();
	pelletList = new ArrayList<Pellet>();
	particleList = new ArrayList<Particle>();
	int i = 0;
	while (i < NUM_DROPLETS) {
		Particle p = new Particle();
		p.randomRestart();
		particleList.add(p);
		i += 1;
	}

	setGame();

	callPellets();

	defineWalls();

}

void draw() {
	if (started == false && firstRun == true) {
		startScreen();
	}

	//Runs draw only when game has been started by mouse press
	if (started == true) {
	background(0);
	
	pacman.spritePrevLocationX = pacman.x;
	pacman.spritePrevLocationY = pacman.y;

	//Draws maze
	for (Wall wall : wallList) {
		wall.render();
	}

	for (Pellet pellet : pelletList) {
		pellet.render();
		pellet.detectCollision();
	}

	pushMatrix();
	translate(pacman.x, pacman.y);
	rotate(pacman.rotation);
	fill(yellow);
	ellipse(0, 0, pacman.radius, pacman.radius);
	fill(0);
	triangle(0, 0, 20, pacman.mouthWide, 20, - pacman.mouthWide);
	pacman.update();
	pacman.detectCollision();
	pacman.moveMouth();
	popMatrix();

	fill(purple);
	image(pinkyGhost, ghost1.x, ghost1.y, ghost1.w, ghost1.h);
	image(inkyGhost, ghost2.x, ghost2.y, ghost2.w, ghost2.h);
	image(blinkyGhost, ghost3.x, ghost3.y, ghost3.w, ghost3.h);
	//rect(ghost.x, ghost.y, ghost.w, ghost.h);

	score();
	ghost1.update();
	ghost1.detectCollision();
	ghost1.spritePrevLocationX = ghost1.x;
	ghost1.spritePrevLocationY = ghost1.y;
	ghost2.update();
	ghost2.detectCollision();
	ghost2.spritePrevLocationX = ghost2.x;
	ghost2.spritePrevLocationY = ghost2.y;
	ghost3.update();
	ghost3.detectCollision();
	ghost3.spritePrevLocationX = ghost3.x;
	ghost3.spritePrevLocationY = ghost3.y;

	while (lives == 0) {
			score = 0;
			lives = 3;
			firstRun = false;
			started = false;
			gameOver();
	} 
	if (score == 303) {
			score = 0;
			lives = 3;
			started = false;
			gameWin();
	}
}
}

//Controls & game start
void keyPressed () {
	if (started == false && firstRun == true){
	}
	else if (started == true && firstRun == false){
	if (key == CODED) {
		if (keyCode == UP) {
				clearMotion();
				pacman.dy = -1.5;
				pacman.spritePrevLocationX = pacman.x;
				pacman.spritePrevLocationY = pacman.y;	
				pacman.rotation = 4.71238898;			
		}
		if (keyCode == DOWN) {
				clearMotion();
				pacman.dy = 1.5;
				pacman.spritePrevLocationX = pacman.x;
				pacman.spritePrevLocationY = pacman.y;
				pacman.rotation = 1.57079633;	
		}
		if (keyCode == LEFT) {
				clearMotion();
				pacman.dx = -1.5;
				pacman.spritePrevLocationX = pacman.x;
				pacman.spritePrevLocationY = pacman.y;
				pacman.rotation = 3.14159265;	
		}
		if (keyCode == RIGHT) {
				clearMotion();
				pacman.dx = 1.5;
				pacman.spritePrevLocationX = pacman.x;
				pacman.spritePrevLocationY = pacman.y;
				pacman.rotation = 0;	
			}

		}
	}
}

void mousePressed(){
	if (firstRun == true 
		&& started == false
		&& mouseX > 200 
		&& mouseX < 450 
		&& mouseY > 350 
		&& mouseY < 400) {
			started = true;
			firstRun = false;
		}
	else if (firstRun == false
		&& started == false
		&& mouseX > 200 
		&& mouseX < 450 
		&& mouseY > 455 
		&& mouseY < 505) {
			started = true;
			firstRun = false;
			setup();
		}
}

//Stops pacman
void clearMotion() {
	pacman.dx = 0;
	pacman.dy = 0;
}

//Shows lives and score
void score() {
	fill(yellow);
	textAlign(CENTER);
	text("Score:" + score, width / 2 , height / 2);
	text("Lives:" + lives, width / 2 , height / 2 - 35);
	textAlign(LEFT);
}