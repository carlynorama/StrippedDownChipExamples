#define PORT *((volatile unsigned char*) 0x38) //(0x20 + 0x18)
#define DDR *((volatile unsigned char*) 0x37)  //(0x20 + 0x17)
#define LED_PIN 1

void delay(volatile long time) {
    while (time != 0) {
        time--;
    }
}

int main() {
    DDR |= (1<<LED_PIN); //this is binary for 32
    //PORT &= ~(1<<LED_PIN);
    while (1) {
        PORT |= (1<<LED_PIN); // pin high OFF FOR ME!!!
        delay(50000);
        PORT &= ~(1<<LED_PIN); // pin low ON FOR ME!!!
        delay(50000);
    }
}