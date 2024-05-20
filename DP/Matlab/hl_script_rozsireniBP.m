%%
clc; clear all; close all;

% define number of vehicles in the platoon
N = 5;

% automatically generating system matrices A,B,C,D and number of states
[A,B,C,D,numOfStates,Cy,Cw1,Cw2] = systemGen(N); 

% automatically generated matrices of symmetry T,G
[R,In,G,T] = symmetryGen(N,A,B);


% define required eigenvalues of the closed loop
q = 10;
p = 110;
r = 1;
% for structure 1 is required only one eigenvalue, all others are ignored
eigenvals = [p q r];
structure = 3;
% structures of Jordan forms
% ------------------------------------------------------------------
% structure 1 -> all eigenvalues are same: defined by lambda
% structure 2 -> one eigenvalue is diffenrent: (2N-1)*lambda, 1*nu
% structure 3 -> two different eigenvalues: N*lambda, (N-1)*nu
% structure 4 - > symmetric LQR, eigenvals = [p=0,q,r] - only positions
% structure 5 - > symmetric LQR, eigenvals = [p,q,r]
% ------------------------------------------------------------------

% automatically calcuted feedback control K for specific Jordan form
K = symFgen(N,numOfStates,eigenvals,structure,A,B)

% closed loop dynamics with feedback control
% if structure == 4
%     K = -K;
% end

Az = A + B*K
eig(Az)

% simulink settings
conds = zeros(1,numOfStates);    % zero init conds

inputDist = 1;
inputSetpoints = 0;
inputInitConds = 0;

setpoints = zeros(numOfStates,1);
if inputSetpoints > 0
    setSpeed = 1;
    setGap = 2;
    setpoints(1:2:numOfStates,1) = setSpeed;
    setpoints(2:2:numOfStates,1) = setGap;
    setpoints;
end

Cw = Cw2;
if inputDist == 1
    Cw = Cw1;
end
if inputInitConds == 1
%     conds = conds + 1;
    for i=1:2:numOfStates
        conds(i) = conds(i) + i;
    end
end

[positions,speeds] = vizualization(N, numOfStates);
%% discrete
clc; clear all; close all;

% define number of vehicles in the platoon
N = 3;

% automatically generating system matrices A,B,C,D and number of states
[A,B,C,D,numOfStates,Cy,Cw1,Cw2] = systemGen(N); 
if N == 3
Kdb = [
    -1.243287507, -1.582121877,  0.6612752881,  0,  0;
     0,            0,           -0.5820122185,  0,  0;
     0,            0,            0.6612752881,  1.582121877, -1.243287507
];
elseif N==4
    Kdb = [-0.5820    0.0000   -0.0000    0.0000    0.0000    0.0000   -0.0000
    0.6613    1.5821   -1.2433    0.0000    0.0000    0.0000   -0.0000
    0.6613    1.5821   -0.0000    1.5821   -1.2433    0.0000   -0.0000
    0.6613    1.5821   -0.0000    1.5821    0.0000    1.5821   -1.2433];
end

structure = 6; % else block in the gains
eigenvals = [1 1 1];

Ts = 1;
sysC = ss(A,B,C,D);
sysD = c2d(sysC,Ts,'zoh');
eig(sysD.A+sysD.B*Kdb)

% simulink settings
conds = zeros(1,numOfStates);    % zero init conds

inputDist = 1;
inputSetpoints = 0;
inputInitConds = 0;

setpoints = zeros(numOfStates,1);
if inputSetpoints > 0
    setSpeed = 1;
    setGap = 2;
    setpoints(1:2:numOfStates,1) = setSpeed;
    setpoints(2:2:numOfStates,1) = setGap;
    setpoints;
end

Cw = Cw2;
if inputDist == 1
    Cw = Cw1;
end
if inputInitConds == 1
%     conds = conds + 1;
    for i=1:2:numOfStates
        conds(i) = conds(i) + i;
    end
end
[positions,speeds] = vizualizationDiscrete(N, numOfStates);
%% vizualization of eigenvalues of the symmetric LQR control
if 1    % if vizualization required - insert 1
    clc; clear all; close all;
    % define required eigenvalues of the closed loop
    p = 7;
    q = 10;
    r = 2;
    % for structure 1 is required only one eigenvalue, all others are ignored
    eigenvals = [p q r];
    structure = 5;

    N = 3;
    cycles = 8;
    eigsVectors = zeros(2*N-1, cycles);
    C = {'c','m','r','b','g',[0.4660 0.6740 0.1880],'y',[0.6350 0.0780 0.1840],[0 0.4470 0.7410],[0.9290 0.6940 0.1250]};
    figure;
    hold on;
    
    for i = 1:cycles
        [A,B,~,~,numOfStates,~,~,~] = systemGen(N); 
        % automatically calcuted feedback control K for specific Jordan form
        Klqr = symFgen(N,numOfStates,eigenvals,structure,A,B);
        AzLQR = A-B*Klqr;
        eigsVectors = eig(AzLQR);
        plot(real(eigsVectors), imag(eigsVectors), 'x', 'color', C{i}, 'DisplayName', sprintf('N = %i',N))
            N = N + 1;
    end
    grid on;
    legend show;
    xlabel('Re(z)')
    ylabel('Im(z)')
    hold off;
end
%%
% transef functions of the MIMO system
s = tf('s');
Fc = simplify(C*((s*eye(numOfStates)-Az)^(-1))*B + D);
% T = [0,0,0,0,0,0,0,0,0,0,1;0,-1,0,-1,0,-1,0,-1,0,-1,0;1,0,0,0,0,0,0,0,0,0,0;0,1,0,0,0,0,0,0,0,0,0;0,0,1,0,0,0,0,0,0,0,0;0,0,0,1,0,0,0,0,0,0,0;0,0,0,0,1,0,0,0,0,0,0;0,0,0,0,0,1,0,0,0,0,0;0,0,0,0,0,0,1,0,0,0,0;0,0,0,0,0,0,0,1,0,0,0;0,0,0,0,0,0,0,0,1,0,0];
for i = 1:N
   prenosy_odch_r(i) = simplify(C(1,:)*((s*eye(numOfStates)-Az)^(-1))*T^(i-1)*B(:,1)) ;
end
for i = 1:N
   prenosy_odch_p(i) = simplify(C(2,:)*((s*eye(numOfStates)-Az)^(-1))*T^(i-1)*B(:,1)) ;
end
%%
H = zeros(1,N-2);    
% string stability condition
a=1:2*N-1;
sude=a(mod(a,2)==0);    % position errors
for i=1:N-2         
H(i) = norm((Fc(sude(i+1),i)/Fc(sude(i),i)),Inf);  % fraction of two vehicles behind
end
H

%%
% BD  condition of string stability - backward
for i=3:N       % vhodny rozsah   
H_zpet(i-2) = norm((Fc(sude(i-2),3)/Fc(sude(i-1),3)),Inf);  % urceni jednotlivych podminek
end
H_zpet
norma = 1;
for i=1:N-1
    norma = norma * Fc(sude(i),i);
end
HC = norm(norma)