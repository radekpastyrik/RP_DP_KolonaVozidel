function [F_o1] = symFgen(N,numOfStates,eigenvals,structureOfDesign,A,B)
% lambda = eigenvals(1);
% ni = eigenvals(2);
F_o = zeros(N, numOfStates);    

% generating feedback matrix
if structureOfDesign == 1
    p = eigenvals(1);
    % the rest of errors of speed
    q = eigenvals(1)^2;
    % errors of distance - have to be correctly multiplied
    
    P = -numOfStates*eigenvals(1) + N; 
    % direct errors of speed
    
    for i = 1:2:numOfStates
        F_o(:,i) = p;
        F_o(ceil(i/2),i) = P;
        for j = i:2:numOfStates-1
            F_o(ceil(i/2), j+1) = -(N-ceil(j/2))*q;
        end
        if i > 1
            for y = 1:i/2
                F_o(ceil(i/2), 2*y) = y*q;
            end
        end
    end
elseif structureOfDesign == 2
    p = 2*eigenvals(1)-eigenvals(2);
    % the rest of errors of speed
    q = eigenvals(1)^2;
    % errors of distance - have to be correctly multiplied
    P = -(numOfStates-1)*eigenvals(1) - eigenvals(2) + N;
    % direct errors of speed
    
    for i = 1:2:numOfStates
        F_o(:,i) = p;
        F_o(ceil(i/2),i) = P;
        for j = i:2:numOfStates-1        
            F_o(ceil(i/2), j+1) = -(N-ceil(j/2))*q;
        end
        if i > 1
            for y = 1:i/2        
                F_o(ceil(i/2), 2*y) = y*q;
            end
        end
    end
elseif structureOfDesign == 3
    p = eigenvals(2);
    % the rest of errors of speed
    q = eigenvals(1)*eigenvals(2);
    % errors of distance - have to be correctly multiplied
    
    P = -N*eigenvals(1) - (N-1)*eigenvals(2) + N; 
    % direct errors of speed
    
    for i = 1:2:numOfStates
        F_o(:,i) = p;
        F_o(ceil(i/2),i) = P;
        for j = i:2:numOfStates-1
            F_o(ceil(i/2), j+1) = -(N-ceil(j/2))*q;
        end
        if i > 1
            for y = 1:i/2
                F_o(ceil(i/2), 2*y) = y*q;
            end
        end
    end
elseif structureOfDesign == 4
    % inputed eigenvals are values p,q,r of the matrix Q,R
%     p = eigenvals(1)^2;
    q = eigenvals(2)^2;
    r = eigenvals(3);
    
    Q=zeros(numOfStates);
    R = eye(N)*r;
    for i = 2:2:numOfStates
        Q(i,2:2:numOfStates) = q;
        Q(i,i) = 2*q;
    end
    
    Q;
    F_o = -lqr(A,B,Q,R)*N;   
elseif structureOfDesign == 5
    % inputed eigenvals are values p,q,r of the matrix Q,R
    p = eigenvals(1);
    q = eigenvals(2);
    r = eigenvals(3);
    
    Q=zeros(numOfStates);
    R = eye(N)*r;
    for i = 2:2:numOfStates
        Q(i,2:2:numOfStates) = q;
        Q(i,i) = 2*q;
    end
    
    for i=1:2:numOfStates
        Q(i,i) = p;
    end
    Q;
    F_o = -lqr(A,B,Q,R)*N;
end
F_o1 = F_o/N;
end

