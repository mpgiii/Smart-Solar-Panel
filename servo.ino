int light1 = A0; // initializes pin values for photoresistor inputs
int light2 = A1;
int light3 = A2;
int light4 = A3;

int out1[] = {22, 23, 24, 25}; // initializes list of pin values
int out2[] = {26, 27, 28, 29}; // for each 4-bit output
int out3[] = {30, 31, 32, 33};
int out4[] = {34, 35, 36, 37};

void setup()
{  
  pinMode(light1, INPUT); // sets our photoresistor pins as inputs
  pinMode(light2, INPUT);
  pinMode(light3, INPUT);
  pinMode(light4, INPUT);

  for (int i = 22; i < 38; i++) // sets all our output pins as outputs
    pinMode(i, OUTPUT);
}

void loop()
{
  int light1reading = analogRead(light1); // reads analog value from pin
  int light2reading = analogRead(light2); // reads as 0-1023 integer
  int light3reading = analogRead(light3);
  int light4reading = analogRead(light4);
  massDigitalWrite(out1, light1reading); // calls function below to write
  massDigitalWrite(out2, light2reading); // the analog value read from the
  massDigitalWrite(out3, light3reading); // pin to our list of pin values
  massDigitalWrite(out4, light4reading); // for each 4-bit output
  delay(10);
}

void massDigitalWrite(int pins[], int toWrite) {
  int newToWrite = toWrite / 64;  // converts the input number to be 0 -
                                  // 16, to allow for bitwise output.
  for (int i = 0; i < 4; i++) {   // this loop outputs each bit to each
                                  // pin in the passed in output array
    digitalWrite(pins[i], bitRead(newToWrite, 3 - i));
  }
}
