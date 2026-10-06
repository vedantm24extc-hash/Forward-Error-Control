# Forward Error Control (FEC) Simulation Using Hamming (7,4) Code

## Overview
This project simulates a digital communication system utilizing Forward Error Control (FEC) to ensure data integrity across a noisy transmission medium[cite: 55]. A Hamming (7,4) error-correcting code was implemented in MATLAB to encode a 4-bit message, transmit it through an Additive White Gaussian Noise (AWGN) channel, and dynamically correct single-bit errors at the receiver[cite: 55]. 

The system's performance is evaluated through two distinct testing methodologies: stage-by-stage discrete waveform visualization and a Bit Error Rate (BER) versus Signal-to-Noise Ratio (SNR) statistical evaluation[cite: 55].

## Key Features
* **Interactive Data Input:** Prompts the user to input a custom 4-bit binary message array with automated format validation.
* **Dynamic Noise Injection:** Mathematically simulates channel degradation by injecting Additive White Gaussian Noise (AWGN) and randomly forcing a bit-flip interference spike.
* **Mathematical Error Correction:** Utilizes modulo-2 arithmetic (XOR logic) to generate parity bits and calculate a 3-bit syndrome at the receiver to instantly locate and invert corrupted bits.
* **Waveform Tracking:** Generates a 3-stage digital step-waveform plot to visually prove the signal lifecycle across the Transmitter, Channel, and Receiver.
* **Monte Carlo Simulation:** Iterates 10,000 random codewords across an SNR spectrum of -5 dB to 10 dB to plot a statistical BER vs. SNR performance curve.

## Repository Contents
* **MATLAB Scripts (`.m`):** The source code containing the logic for the Hamming Encoder/Decoder, AWGN channel simulation, and BER calculations.
* **Project Report (`dc_project.pdf`):** A comprehensive technical document detailing the mathematical formulations, system overview, and analytical results[cite: 53, 54].
* **Simulation Results:** Image files demonstrating the successfully generated waveforms and BER curves.

## Prerequisites
* MATLAB (No specific supplementary communication toolboxes are required as the logic utilizes core mathematical functions).

## How to Run
1. Download or clone this repository to your local machine.
2. Open MATLAB and navigate to the repository folder.
3. **To test the logic:** Run the primary simulation script. The Command Window will prompt you to enter a 4-bit array (e.g., `[1, 0, 1, 1]`). Hit Enter to view the localized error-correction waveforms.
4. **To view statistical performance:** Run the BER curve script. The program will execute the 10,000-trial loop and generate the logarithmic performance graph.

## Authors
* **Vedant Mishra**[cite: 53]
* **Anuj Meher**[cite: 53]
* Department of Electronics and Telecommunication Engineering, Pillai College of Engineering[cite: 53]
