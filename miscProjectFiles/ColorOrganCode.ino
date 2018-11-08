/*
  This Example acquire analog signal from A0 of Arduino, and Serial out to Proc
  essing application to visualize.
  Tested with preamplified audio data. Take a look at http://www.youtube.com/wa
  tch?v=drYWullBWcI
  Analog signal is captured at 9.6 KHz, 64 spectrum bands each 150Hz which can
  be change from adcInit()
  Load the this file to Arduio, run Processing application.
  Original Fixed point FFT library is from ELM Chan, http://elm-
  chan.org/works/akilcd/report_e.html
  Ported to the library and demo codes are from AMurchick http://arduino.cc/for
  um/index.php/topic,37751.0.html
  Processing code is from boolscott http://boolscott.wordpress.com/2010/02/04/a
  rduino-processing-analogue-bar-graph-2/
*/

#include <stdint.h>
#include <ffft.h>
#define
volatile
volatile
IR_AUDIO
byte
long
0 // ADC channel to capture
position = 0;
zero = 0;
int16_t capture[FFT_N];
/* Wave captureing buffer */
complex_t bfly_buff[FFT_N];
/* FFT buffer */
uint16_t spektrum[FFT_N / 2];
/* Spectrum output buffer */
const byte RedLED = 9, GreenLED = 10, BlueLED = 11;
int Red, Blue, Green, Sum;
volatile byte RedOut, GreenOut, BlueOut;

void setup()
{
  adcInit();
  //Initialises the ADC with the sampling frequency and ADMUX
  adcCalb();
  //Calibrates the ADC by subtracting the equivalent of 2.5V
  (the addition of voltage)
}

void loop()
{
  if (position == FFT_N)
  {
    fft_input(capture, bfly_buff);
    fft_execute(bfly_buff);
    fft_output(bfly_buff, spektrum);
    for (byte i = 0; i < 64; i++) {
      if (i < 3) Red += spektrum[i];
      if ((i >= 3) && (i <= 20)) Green += spektrum[i];
      if ((i > 20) && (i < 65)) Blue += spektrum[i];
    }
    Sum = (Red + Green + Blue);
    if ((ADC > 519) || (ADC < 505))
      // Checks if the magnitude of incoming signal is large enough (to eliminate output due to noise)
    {
      //Note that at NO signal output is 512, so with small signals it would be 505 to 519 (approx)
      RedOut = (Red * 255) / Sum;
      //The value is normalized to a scale of 255 so as to create uniform lighting
      GreenOut = (Green * 255) / Sum;
      BlueOut = (Blue * 255) / Sum;
    }
    else
    {
      RedOut = 0;
      GreenOut = 0;
      BlueOut = 0;
    }
    if ((Red > Green) && (Red > Blue))
    {
      analogWrite(RedLED, 255 - RedOut);
      //"255-Value" is used because the
      LED has been connected to VCC
      analogWrite(GreenLED, 255);
      // So it is off at 255 and
      completely ON at 0
      analogWrite(BlueLED, 255);
    }
    else if ((Green > Red) && (Green > Blue))
    {
      analogWrite(RedLED, 255);
      analogWrite(BlueLED, 255);
      analogWrite(GreenLED, 255 - GreenOut);
    }
    else
    {
      analogWrite(GreenLED, 255);
      analogWrite(RedLED, 255);
      analogWrite(BlueLED, 255 - BlueOut);
    }
    Red = 0;
    Blue = 0;
    Green = 0;
    position = 0;
  }
}

void adcInit() {
  /* REFS0 : VCC use as a ref, IR_AUDIO : channel selection, ADEN : ADC
    Enable, ADSC : ADC Start, ADATE : ADC Auto Trigger Enable, ADIE : ADC
    Interrupt Enable, ADPS : ADC Prescaler */
  // free running ADC mode, f = ( 16MHz / prescaler ) / 13 cycles per
  conversion
  ADMUX = _BV(REFS0) | IR_AUDIO; // | _BV(ADLAR);
  ADCSRA = _BV(ADSC) | _BV(ADEN) | _BV(ADATE) | _BV(ADIE) | _BV(ADPS2) | _BV(
             ADPS1); //prescaler 64 : 19231 Hz - 300Hz per 64 divisions
  // ADCSRA = _BV(ADSC) | _BV(ADEN) | _BV(ADATE) | _BV(ADIE) | _BV(ADPS2) | _B
  V(ADPS1) | _BV(ADPS0); // prescaler 128 : 9615 Hz -
  150 Hz per 64 divisions, better for most music
  sei();
}

void adcCalb() {
  long midl = 0;
  // get 2 measurements at 2 sec
  // There should be on signal on ADC input while doing this
  for (byte i = 0; i < 2; i++)
  {
    position = 0;
    delay(100);
    midl += capture[0];
    delay(900);
  }
  zero = -midl / 2;
}

// free running ADC fills capture buffer
// The samples are taken using interrupt so as to manage time efficiently
ISR(ADC_vect)
{
  if (position >= FFT_N)
    return;
  capture[position] = ADC + zero;
  if (capture[position] == -1 || capture[position] == 1)
    can be even or odd
    capture[position] = 0;
  position++;
}

}

