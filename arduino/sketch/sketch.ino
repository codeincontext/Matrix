int pauseDelay = 1;    //the number of milliseconds to display each scanned line
//int pauseDelay = 10;    //the number of milliseconds to display each scanned line

//Pin Definitions
int rowA[] = {9,8,7,6,5,4,3,2};          //An Array defining which pin each row is attached to
                                         //(rows are common anode (drive HIGH))
int colA[] = {17,16,15,14,13,12,11,10};  //An Array defining which pin each column is attached to
                                         //(columns are common cathode (drive LOW))
//The array used to hold a bitmap of the display
byte data[] = {0,0,0,0,0,0,0,0};    


void setup() { 
  for(int i = 0; i <8; i++){  //Set the 16 pins used to control the array as OUTPUTs
    pinMode(rowA[i], OUTPUT);
    pinMode(colA[i], OUTPUT);
  }
  Serial.begin(9600);
}

void loop() {
  //  Wait until we have the start byte)
    if (Serial.available() < 1) { showSprite(); }
   
  //  Check we're starting at the right place
    if (Serial.read() == 0x55) {
      //  Wait until we have the start byte)
      while (Serial.available() < 1) { showSprite(); }
      if (Serial.read() == 0xAA) {
        //  Ensure that we have 8 data bytes
        while (Serial.available() < 9) { showSprite(); }
          
        for (int i=0; i<8; i++) {
            data[i] = Serial.read();
        }

        showSprite();
      }
    }
}

void showSprite(){
  for(int column = 0; column < 8; column++){            //iterate through each column
   for(int i = 0; i < 8; i++){                          
       digitalWrite(rowA[i], LOW);                      //turn off all row pins  
   }
   for(int i = 0; i < 8; i++){ //Set only the one pin
     if(i == column){     digitalWrite(colA[i], LOW);}  //turns the current row on
     else{                digitalWrite(colA[i], HIGH); }//turns the rest of the rows off
   }

   for(int row = 0; row < 8; row++){                    //iterate through each pixel in the current column
    int bit = (data[column] >> row) & 1;
    if(bit == 1){ 
       digitalWrite(rowA[row], HIGH);                   //if the bit in the data array is set turn the LED on
    }

   }
   delay(pauseDelay);                       //leave the column on for pauseDelay microseconds (too high a delay causes flicker)
  }
}
