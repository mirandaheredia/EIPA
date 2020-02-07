

% Miranda Heredia 
clear all
close all


%Part i
nx=50;
ny=50;
G= sparse(nx*ny,nx*ny);

%Part ii and iii - loop for spatial matrix
for i= 1:nx
    for j= 1:ny
        n=j+(i-1)*ny; %current position 
        %Local mapping of the nodes around (x,y)
        nxm = j + (i-2)*ny; 
        nxp = j + (i)*ny;
        nym = j-1 + (i-1)*ny;
        nyp = j+1 + (i-1)*ny;
        if i ==1 || i==nx || j==1 || j==ny
            G(n,:)=0;
            G(n,n)=1;
        elseif i > 10 && i < 20 && j > 10 && j < 20
            G(n, n) = -2;
            G(n, nxm) = 1;
            G(n, nxp) = 1;
            G(n, nym) = 1;
            G(n, nyp) = 1;
        else
            G(n,n)= -4;
            G(n,nxm)= 1;
            G(n,nym)= 1;
            G(n,nyp)= 1;
            G(n,nxp)= 1;
        end
    end       
end
figure(1)
spy(G)
title('sparse matrix G')

%v
[E,D]= eigs(G,9,'SM');

Eigen = diag(D);

figure(2)
plot(Eigen);
xlabel("Eigenvalue #");
ylabel("Eigenvalue");
title("Eigenvalues");

% Plot the eigenvalues on surf

Evectors = zeros(nx, ny);
%vector remapping to plot eigenvectors
for k=1:9
    for i=1:nx
        for j=1:ny
            N = j +(i-1)*ny;
            Evectors(i,j) = E(N,k);
        end
    end
    figure(3)
    surf(Evectors)
    grid on
    colormap(parula)
    pause(0.5)
end




% changing nx = 50 and ny = 51 gave an error due to eigs requiring a square
% matrix as an input














