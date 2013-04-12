boolean isExtruding=false;
int height = 0;
int heightPin = 4;
int extruderPin = 9;

void setup() {
    pinMode(4,INPUT);
    pinMode(9,OUTPUT);
    Serial.begin(9600);
}

void pullHigh(int pin) {
        pinMode(pin, OUTPUT);
        digitalWrite(pin, LOW);
        delayMicroseconds(2);
        digitalWrite(pin, HIGH);
        delayMicroseconds(5);
        digitalWrite(pin, LOW);
}

// BEGIN loop()
void loop() {

    // Wait until we are 30 cm above the ground
    height = pulseIn(heightPin, HIGH);             // open extruder

    if ( height > 30 && height < 100 && false == isExtruding ) {
      pullHigh(extruderPin);
    }

    // Wait until we are 100 cm above
    if (  height > 100 && isExtruding ) {
        pinMode(extruderPin, OUTPUT);
        digitalWrite(extruderPin, LOW); // close extruder
    }

} // END loop()

