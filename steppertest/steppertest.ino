int aPin = 1;
int val = 0;

int dirPin = 8;
int stepPin = 9;

int low = 400;
int high = 800;

int loopcount = 200;


void setup() {
	Serial.begin(9600);
	pinMode(dirPin, OUTPUT);
	pinMode(stepPin, OUTPUT);
}

void loop() {
	val = analogRead(aPin);
	Serial.println(val);
	if (val < low) {
	digitalWrite(dirPin, LOW);
		for (int i = 0; i < 200; i ++ ) {
			digitalWrite(stepPin, LOW);
			delayMicroseconds(500);
			digitalWrite(stepPin, LOW);
			delayMicroseconds(500);
		}
	}
	if (val > high) {
	digitalWrite(dirPin, HIGH);
		for (int i = 0; i < 200; i ++ ) {
			digitalWrite(stepPin, LOW);
			delayMicroseconds(500);
			digitalWrite(stepPin, LOW);
			delayMicroseconds(500);
		}
	}
}
