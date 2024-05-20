function [A,B,C,D, numOfStates, Cy, Cw1,Cw2] = systemGen(N)
% automatically matrices A,B,C,D
numOfStates = 2*N-1;
A = zeros(numOfStates);
B = zeros(numOfStates,N);
Cy = zeros(N,numOfStates);
Cw1 = Cy;
Cw2 = Cy;

for i = 1:2:(numOfStates)
   A(i,i) = -1;
   A(i+1,i) = 1;
   A(i+1,i+2) = -1;
end
for i = 1:2:(numOfStates)
    B(i,ceil(i/2)) = 1;
    Cy(ceil(i/2),i) = 1;
    if i < numOfStates
        Cw1(ceil(i/2),i+1) = 1;
        Cw2(ceil(i/2),i+1) = 1;
    else
        for j = 2:2:numOfStates-1
        Cw1(N,j) = -1;
%         Cw2(N,j) = -1/(N-1);
        Cw2(N,j) = 1/(N-1);
        end 
    end
end
A = A(1:(numOfStates),1:(numOfStates));
C = eye(numOfStates);
D = zeros(numOfStates,N);
end