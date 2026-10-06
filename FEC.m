clc; clear; close all;

%% 1. TRANSMITTER STAGE
% Prompt the user for custom data
D = input('Enter a 4-bit binary message as an array (e.g., [1, 0, 1, 1]): ');

% Validation check to ensure strict 4-bit binary format
while length(D) ~= 4 || ~all(ismember(D, [0, 1]))
    disp('Error: Invalid format. You must enter exactly four binary digits.');
    D = input('Please enter a valid 4-bit array (e.g., [1, 0, 1, 1]): ');
end

% Calculate Parity Bits
P1 = mod(D(1) + D(2) + D(4), 2);
P2 = mod(D(1) + D(3) + D(4), 2);
P3 = mod(D(2) + D(3) + D(4), 2);

codeword = [D, P1, P2, P3]; % 7-bit codeword

% Initialize the main figure and plot the first graph (Top)
figure('Name', 'FEC Stage-by-Stage Signals');
subplot(3,1,1);
stairs([codeword, codeword(end)], 'b', 'LineWidth', 2);
title('Transmitter: Encoded Hamming (7,4) Signal');
xlabel('Bit Position'); ylabel('Binary State');
ylim([-0.5 1.5]); grid on;


%% 2. CHANNEL STAGE
received_seq = codeword;

% Generate a random error position between 1 and 7
error_pos = randi([1, 7]);

% Simulate interference by flipping the randomly chosen bit
received_seq(error_pos) = ~received_seq(error_pos);

% Plot the second graph (Middle)
subplot(3,1,2);
stairs([received_seq, received_seq(end)], 'r', 'LineWidth', 2);

% Dynamically update the title to display the exact randomized error position
title(['Channel: Noisy Received Signal (Random Error at bit ', num2str(error_pos), ')']);
xlabel('Bit Position'); ylabel('Binary State');
ylim([-0.5 1.5]); grid on;

%% 3. RECEIVER STAGE
% Calculate Syndrome
S1 = mod(received_seq(1) + received_seq(2) + received_seq(4) + received_seq(5), 2);
S2 = mod(received_seq(1) + received_seq(3) + received_seq(4) + received_seq(6), 2);
S3 = mod(received_seq(2) + received_seq(3) + received_seq(4) + received_seq(7), 2);
syndrome = [S1, S2, S3];

% Locate the error
error_index = 0; 
if isequal(syndrome, [1, 1, 0])
    error_index = 1;
elseif isequal(syndrome, [1, 0, 1])
    error_index = 2;
elseif isequal(syndrome, [0, 1, 1])
    error_index = 3;
elseif isequal(syndrome, [1, 1, 1])
    error_index = 4;
elseif isequal(syndrome, [1, 0, 0])
    error_index = 5;
elseif isequal(syndrome, [0, 1, 0])
    error_index = 6;
elseif isequal(syndrome, [0, 0, 1])
    error_index = 7;
end

% Correct the error
if error_index > 0
    received_seq(error_index) = ~received_seq(error_index);
end

% Plot the third graph (Bottom)
subplot(3,1,3);
stairs([received_seq, received_seq(end)], 'g', 'LineWidth', 2);
title('Receiver: Corrected Hamming (7,4) Signal');
xlabel('Bit Position'); ylabel('Binary State');
ylim([-0.5 1.5]); grid on;
