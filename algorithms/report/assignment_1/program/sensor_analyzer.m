close all;
clear;
clc;

load("data2.mat") %dataset z 5 běhů a každý obsahuje 1000 bodnot pro každý senzor

mean_lidar = squeeze(mean(lidar_all, 2));
mean_gnss = squeeze(mean(gnss_all, 2));

start_pos = [15 11];


%% TASK 2
% pro běh 1
beh = 1;
beh_number = 1;

for beh = 1:beh_number
    % beh = 1;
    lidar = reshape(lidar_all(beh,:,:), [], 8);
    gnss  = reshape(gnss_all(beh,:,:),  [], 2);
    
    lidar = lidar - mean(lidar);
    gnss  = gnss  - mean(gnss);
    % gnss  = gnss  - start_pos;
    
    sigma_lidar = std(lidar);   
    sigma_gnss  = std(gnss);  
    
    figure;
    for k = 1:8
        subplot(2,4,k);
        histogram(lidar(:,k));
        title(['LiDAR ', num2str(k), ' - číslo běhu - ', num2str(beh)]);
        % title(['LiDAR ', num2str(k)]);
    end
    
    figure;
    subplot(1,2,1);
    histogram(gnss(:,1));
    title(['GNSS X', ' - číslo běhu - ', num2str(beh)]);
    % title(['GNSS X']);

    subplot(1,2,2);
    histogram(gnss(:,2));
    title(['GNSS Y', ' - číslo běhu - ', num2str(beh)]);
    % title(['GNSS Y']);
    
    disp("--------------------------")
    disp('Běh číslo:');
    disp(beh);

    disp('LiDAR std:');
    disp(sigma_lidar);
    
    disp('GNSS std:');
    disp(sigma_gnss);
end
disp("--------------------------")

%% TASK 3
cov_lidar = cov(lidar);
cov_gnss  = cov(gnss);

disp("kontrola LIDAR:");
disp(diag(cov_lidar)');
disp(sigma_lidar.^2);

disp("Kontrola GNSS:");
disp(diag(cov_gnss)');
disp(sigma_gnss.^2);
 
%% TASK 4



mu = 0;
x = linspace(-2, 2, 10000);

pdf_lidar = norm_pdf(x, mu, sigma_lidar(1));
pdf_gnss  = norm_pdf(x, mu, sigma_gnss(1));

figure;
plot(x, pdf_lidar, 'LineWidth', 2); hold on;
plot(x, pdf_gnss, 'LineWidth', 2);
xlabel('Chyba měření (m)')
ylabel('PDF')
title('Normální rozdělení šumu z LIDARU a GNSS přijímače')
legend('LIDAR 1. paprsek', 'GNSS X');

grid on;

