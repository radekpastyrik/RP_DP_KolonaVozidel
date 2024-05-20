function [positionOfVehicles,speedOfVehicles] = vizualization(N, numOfStates)
 %grafy
 
if N == 3
    simul = sim('vozidla3_komplet');
elseif N==4
    simul = sim('vozidla4_komplet');
elseif N==5
    simul = sim('vozidla5_komplet');
elseif N==6
    simul = sim('vozidla6_komplet');
end

speedOfVehicles = simul.vystup.signals.values(:,1:N);
positionOfVehicles = simul.vystup.signals.values(:,N+1:numOfStates+1);
t = simul.tout(:);
figure;
plot(t,positionOfVehicles(:,1),'blue')
hold on;
plot(t,positionOfVehicles(:,2), 'red')
% plot(t,positionOfVehicles(:,3)/(-2), 'green--')
plot(t,positionOfVehicles(:,3), 'green--')
if N==3
    legend('$\delta w_1$', '$\delta w_2$', '$\delta w_3$', 'Interpreter','latex')
elseif N == 4
    plot(t,positionOfVehicles(:,4), 'k--')
    legend('$\delta w_1$', '$\delta w_2$', '$\delta w_3$', '$\delta w_4$', 'Interpreter','latex')
elseif N==5
    plot(t,positionOfVehicles(:,4), 'k--')
    plot(t,positionOfVehicles(:,5), 'm--')
    legend('$\delta w_1$', '$\delta w_2$', '$\delta w_3$', '$\delta w_4$', '$\delta w_5$', 'Interpreter','latex')
elseif N==6
    plot(t,positionOfVehicles(:,4), 'k--')
    plot(t,positionOfVehicles(:,5), 'm--')
    plot(t,positionOfVehicles(:,6), 'c--')
    legend('$\delta w_1$', '$\delta w_2$', '$\delta w_3$', '$\delta w_4$', '$\delta w_5$', '$\delta w_6$','Interpreter','latex')
end
title('Prubeh regulace odchylek od polohy kolony vozidel')
xlabel('cas [s]')
ylabel('odchylka od polohy [m]')
grid on;
xlim([t(1) t(end)]);

figure;
plot(t,speedOfVehicles(:,1), 'blue')
hold on;
plot(t,speedOfVehicles(:,2), 'red')
plot(t,speedOfVehicles(:,3), 'green--')
if N==3  
legend('$\delta y_1$', '$\delta y_2$', '$\delta y_3$', 'Interpreter','latex')
elseif N==4
    plot(t,speedOfVehicles(:,4), 'k--')
    legend('$\delta y_1$', '$\delta y_2$', '$\delta y_3$','$\delta y_4$', 'Interpreter','latex')
elseif N==5
    plot(t,speedOfVehicles(:,4), 'k--')
    plot(t,speedOfVehicles(:,5), 'm--')
    legend('$\delta y_1$', '$\delta y_2$', '$\delta y_3$','$\delta y_4$', '$\delta y_5$', 'Interpreter','latex')
elseif N==6
    plot(t,speedOfVehicles(:,4), 'k--')
    plot(t,speedOfVehicles(:,5), 'm--')
    plot(t,speedOfVehicles(:,6), 'c--')
    legend('$\delta y_1$', '$\delta y_2$', '$\delta y_3$','$\delta y_4$', '$\delta y_5$','$\delta y_6$', 'Interpreter','latex')
end
title('Prubeh regulace odchylek od rychlosti kolony vozidel')
xlabel('cas [s]')
ylabel('odchylka od rychlosti [m/s]')
grid on;
xlim([t(1) t(end)]);
end

