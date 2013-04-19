#include <WProgram.h>

boolean isExtruding=false;
long height = 0;
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
    pinMode(heightPin, INPUT);
    int duration=pulseIn(heightPin, HIGH);            
    height = microsecondsToCentimeters(duration);

    if ( height > 30 && height < 100 && false == isExtruding ) {
      pullHigh(extruderPin);
    }

    // Wait until we are 100 cm above
    if (  height > 100 && isExtruding ) {
        pinMode(extruderPin, OUTPUT);
        digitalWrite(extruderPin, LOW); // close extruder
    }

} // END loop()

long microsecondsToCentimeters(long microseconds)
{
    // The speed of sound is 340 m/s or 29 microseconds per centimeter.
    // The ping travels out and back, so to find the distance of the
    // object we take half of the distance travelled.
    return microseconds / 29 / 2;
}
