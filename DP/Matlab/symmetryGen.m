function [R,In,G,T] = symmetryGen(N,A,B)
R = ctrb(A,B);
In = eye(2*N-1);

G = zeros(N);
G(1,N) = 1;
for i = 2:N
	G(i,i-1) = 1;
end

T = R*kron(In,G)*R'*(R*R')^(-1);
end

