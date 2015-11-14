#include <Servo.h>

Servo pan;
Servo tilt;

int xpin = 1;
int ypin = 2;

int xval = 0;
int yval = 0;

void setup() {
	pan.attach(3);
	tilt.attach(5);
}

void loop() {
	xval = analogRead(xpin);
	yval = analogRead(ypin);
	delay(100);
	pan.write(map(xval,0,1023, 0,180));
	tilt.write(map(yval,0,1023, 0,180));
}
	

