%% FULL FEC SYSTEM: Hamming (7,4) BER vs SNR Simulation
clc; clear; close all;

% 1. Setup Simulation Parameters
SNR_dB = -5:2:10; % Range of noise levels to test
BER = zeros(1, length(SNR_dB)); % Array to store our results
num_trials = 10000; % Number of messages to send per SNR level

disp('Starting simulation, please wait...');

% 2. Main Simulation Loop
for i = 1:length(SNR_dB)
    total_errors = 0; % Reset error count for each SNR level

    for trial = 1:num_trials
        % --- TRANSMITTER ---
        D = randi([0, 1], 1, 4); 
        P1 = mod(D(1) + D(2) + D(4), 2);
        P2 = mod(D(1) + D(3) + D(4), 2);
        P3 = mod(D(2) + D(3) + D(4), 2);
        codeword = [D, P1, P2, P3];

        % --- CHANNEL ---
        transmitted_signal = 2 * codeword - 1; 
        noisy_signal = awgn(transmitted_signal, SNR_dB(i), 'measured');
        received_seq = noisy_signal > 0;

        % --- RECEIVER ---
        S1 = mod(received_seq(1) + received_seq(2) + received_seq(4) + received_seq(5), 2);
        S2 = mod(received_seq(1) + received_seq(3) + received_seq(4) + received_seq(6), 2);
        S3 = mod(received_seq(2) + received_seq(3) + received_seq(4) + received_seq(7), 2);
        syndrome = [S1, S2, S3];

        error_index = 0; 
        if isequal(syndrome, [1, 1, 0]), error_index = 1;
        elseif isequal(syndrome, [1, 0, 1]), error_index = 2;
        elseif isequal(syndrome, [0, 1, 1]), error_index = 3;
        elseif isequal(syndrome, [1, 1, 1]), error_index = 4;
        elseif isequal(syndrome, [1, 0, 0]), error_index = 5;
        elseif isequal(syndrome, [0, 1, 0]), error_index = 6;
        elseif isequal(syndrome, [0, 0, 1]), error_index = 7;
        end

        if error_index > 0
            received_seq(error_index) = ~received_seq(error_index);
        end

        recovered_data = received_seq(1:4);
        total_errors = total_errors + sum(D ~= recovered_data);
    end

    % Calculate BER
    BER(i) = total_errors / (num_trials * 4);
end

% 3. Generate the Final Graph
figure('Name', 'BER Performance');
semilogy(SNR_dB, BER, 'b-o', 'LineWidth', 2);
title('BER vs SNR for Hamming (7,4) Code');
xlabel('Signal-to-Noise Ratio (SNR in dB)');
ylabel('Bit Error Rate (BER)');
grid on;
disp('Simulation complete! BER Graph generated.');
