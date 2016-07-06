void startScreen() {
	imageMode(CENTER);
	pacmanlogo = loadImage("pacmanlogo.jpg");
	vcrfont = loadFont("VCROSDMono-60.vlw");
	background(0);
	image(pacmanlogo, width / 2, pacmanlogo.height / 2, width, pacmanlogo.height);
	textAlign(CENTER);
	fill(255);
	textFont(vcrfont, 60);
	text("CMPT 166 PROJECT 4", width / 2, height / 3);
	textFont(vcrfont, 32);
	textSize(16);
	text("USE THE ARROW KEYS TO CONTROL PACMAN", width / 2, height / 2 + 60);
	textSize(32);
	fill(0, 200, 0);
	rectMode(CORNERS);
	rect(200, 350, 450, 400);
	rectMode(CORNER);
	fill(255);
	text("PLAY GAME", width / 2, height / 2 + 10);
	textAlign(LEFT);
	textSize(24);
	text("MACGUIRE RINTOUL", 3 * pix, height - height / 6);
	text("301258009", 3 * pix, height - height / 8);
	textAlign(RIGHT);
	text("JOSHUA STUIBLE", width - 3 * pix, height - height / 6);
	text("301263641", width - 3 * pix, height - height / 8);

	imageMode(CORNER);
	image(introImage, introSprite.x, introSprite.y, introImage.width, introImage.height);
	introSprite.update();

	for (Particle p : particleList) {
		p.render();
		p.update();
	}

	if (introSprite.x > width) {
		introSprite.x = 0 - introImage.width;
	}
}