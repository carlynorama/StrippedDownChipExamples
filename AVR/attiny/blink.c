//10.4.2 PORTB – Port B Data Register
#define PORTB *((volatile unsigned char*) 0x38) //(0x20 + 0x18)
//10.4.3 DDRB – Port B Data Direction Register
#define DDRB *((volatile unsigned char*) 0x37)  //(0x20 + 0x17)

#define LED_PIN 3

void delay(volatile long time) {
    while (time != 0) {
        time--;
    }
}

int main() {
    DDRB |= (1<<LED_PIN); 
    //PORT &= ~(1<<LED_PIN);
    while (1) {
        PORTB |= (1<<LED_PIN); // pin high OFF FOR ME!!!
        delay(50000);
        PORTB &= ~(1<<LED_PIN); // pin low ON FOR ME!!!
        delay(50000);
    }
}