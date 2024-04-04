//10.4.2 PORTB – Port B Data Register
#define PORTB *((volatile unsigned char*) 0x38) //(0x20 + 0x18)
//10.4.3 DDRB – Port B Data Direction Register
#define DDRB *((volatile unsigned char*) 0x37)  //(0x20 + 0x17)
//10.4.4 PINB – Port B Input Pins Address
#define PINB *((volatile unsigned char *)0x36)  //(0x20 + 0x16)

#define LED_PIN 3
#define SWITCH_PIN 4

int main() {
    //set led pin bit to output
    DDRB |= (1<<LED_PIN);  
    
    //set switch pin bit to input
    DDRB &= ~(1<<SWITCH_PIN); 
     //for voltage high == no press config, sets pull up.
    PORTB |= (1<<SWITCH_PIN);
    //give the pull up a moment.
    
    //TODO pullup is slow to warm up.

    while (1) {
        if (!(PINB & (1<<SWITCH_PIN))) {  //if pressed
        //above if compares (0x000?0000 & 0x00010000) => 
        // - if true, seeing pull up. button not pressed
        // - if false, seeing ground via closed switch, button pressed
            PORTB &= ~(1<<LED_PIN);   // pin low, LED ON
        } else {
            PORTB |= (1<<LED_PIN);    // pin high, LED OFF 
        }
    }
}