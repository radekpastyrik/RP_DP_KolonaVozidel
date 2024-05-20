function [positionOfVehicles,speedOfVehicles] = vizualizationDiscrete(N, numOfStates)
 %grafy
 
if N == 3
    simul = sim('vozidla3_discrete');
elseif N==4
    simul = sim('vozidla4_discrete');
end

length(simul.tout)
length(simul.vystup.signals.values(:,1))
if length(simul.tout) <= length(simul.vystup.signals.values(:,1))
    lengthOfSignals = length(simul.tout)
else
    lengthOfSignals = length(simul.vystup.signals.values(:,1))
end
speedOfVehicles = simul.vystup.signals.values(1:lengthOfSignals,1:N);
positionOfVehicles = simul.vystup.signals.values(1:lengthOfSignals,N+1:numOfStates+1);
t = simul.tout(1:lengthOfSignals);
figure;
stairs(t,positionOfVehicles(:,1),'blue');
hold on;
stairs(t,positionOfVehicles(:,2), 'red');
% stairs(t,positionOfVehicles(:,3)/(-2), 'green--')
stairs(t,positionOfVehicles(:,3), 'green--');
if N==3
    legend('$\delta w_1$', '$\delta w_2$', '$\delta w_3$', 'Interpreter','latex')
elseif N == 4
    stairs(t,positionOfVehicles(:,4), 'k--')
    legend('$\delta w_1$', '$\delta w_2$', '$\delta w_3$', '$\delta w_4$', 'Interpreter','latex')
elseif N==5
    stairs(t,positionOfVehicles(:,4), 'k--')
    stairs(t,positionOfVehicles(:,5), 'm--')
    legend('$\delta w_1$', '$\delta w_2$', '$\delta w_3$', '$\delta w_4$', '$\delta w_5$', 'Interpreter','latex')
elseif N==6
    stairs(t,positionOfVehicles(:,4), 'k--')
    stairs(t,positionOfVehicles(:,5), 'm--')
    stairs(t,positionOfVehicles(:,6), 'c--')
    legend('$\delta w_1$', '$\delta w_2$', '$\delta w_3$', '$\delta w_4$', '$\delta w_5$', '$\delta w_6$','Interpreter','latex')
end
title('Prubeh regulace odchylek od polohy kolony vozidel')
xlabel('cas [s]')
ylabel('odchylka od polohy [m]')
grid on;
xlim([t(1) t(end)]);

figure;
stairs(t,speedOfVehicles(:,1), 'blue');
hold on;
stairs(t,speedOfVehicles(:,2), 'red');
stairs(t,speedOfVehicles(:,3), 'green--');
if N==3  
legend('$\delta y_1$', '$\delta y_2$', '$\delta y_3$', 'Interpreter','latex')
elseif N==4
    stairs(t,speedOfVehicles(:,4), 'k--')
    legend('$\delta y_1$', '$\delta y_2$', '$\delta y_3$','$\delta y_4$', 'Interpreter','latex')
elseif N==5
    stairs(t,speedOfVehicles(:,4), 'k--')
    stairs(t,speedOfVehicles(:,5), 'm--')
    legend('$\delta y_1$', '$\delta y_2$', '$\delta y_3$','$\delta y_4$', '$\delta y_5$', 'Interpreter','latex')
elseif N==6
    stairs(t,speedOfVehicles(:,4), 'k--')
    stairs(t,speedOfVehicles(:,5), 'm--')
    stairs(t,speedOfVehicles(:,6), 'c--')
    legend('$\delta y_1$', '$\delta y_2$', '$\delta y_3$','$\delta y_4$', '$\delta y_5$','$\delta y_6$', 'Interpreter','latex')
end
title('Prubeh regulace odchylek od rychlosti kolony vozidel')
xlabel('cas [s]')
ylabel('odchylka od rychlosti [m/s]')
grid on;
xlim([t(1) t(end)]);
end


