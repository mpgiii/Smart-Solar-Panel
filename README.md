# Solar Tracker

Designed by Michael Georgariou and Jack Ellison.

Please note that this assembly program is to be uploaded to the RAT MCU, which Jack and I also both designed. You can see the source code for this here: https://github.com/mpgiii/RAT-MCU

## Introduction

This device directs a 5V, 100mA-rated solar panel at the most intense source of light around. If used outside during the day, the solar panel will point at the sun for maximum efficiency. The device is set up with an Arduino Mega 2560 reading 4 analog voltage inputs from photoresistors and outputting four 4-bit digital outputs. The Basys 3, running our RAT MCU will read two 8-bit inputs from the Arduino (representing four 4-bit outputs). Based on the readings the RAT MCU receives, it will output two 3.3V square waves to control each servo motor.

## Expected Functionality

When running correctly, the solar panel will position itself to face the strongest source of light directly. Once set up, this device requires no more operation and nothing externally will be displayed. There are two leads soldered to the solar panel which will be live with up to 5 V, which can be used for whatever purpose the user would like. The positioning may work strangely at night, but because of the way the device itself functions, it will correct itself once the sun rises the next morning. Do not use this device at night, as it will not provide a steady voltage or amperage at lower level lights. The device can be set down anywhere, but it is recommended it is put somewhere where shade and obstructions will not be an issue, such as a rooftop.

## Required Components

- Arduino Mega 2560
- Basys 3 (Programmed with the RAT MCU)
- Breadboard
- 5V 100mA Solar Panel
- Photoresistor (x4)
- 1k ohm resistory (x4)
- Servo motor (x2)

## Setup Instructions

- Glue 4 photoresistors to the sides of the solar panel so that they are facing the same direction as the top of the panel.
- Cut 3”x3” cardboard squares and glue them on top of each other until you have 1.5” layered. Glue this stack to the bottom of the solar panel, centered but flush on one side.
- Make sure one servo is centered and glue its mounting face to the side of the cardboard stack. Do the same with the other servo and glue its mounting face to the side of the other servo, so that the panel can rotate about 2 axes.
- Connect 8 Male/Female jumper wires to the leads of the photoresistors.
- Using the breadboard, Arduino, Basys 3, resistors, and solar panel setup, create the circuit shown in Figure A with Male/Male jumper wires.
- Make sure the Basys 3 is connected to USB power and switched on. Connect the Basys 3 and Arduino to a computer and upload the provided code to each board. (Note: when the bitstream is uploaded to the Basys 3, both servos will “jump” to the centered position). The device should run properly until you disconnect from a computer or flip the power switch on the Basys 3.
