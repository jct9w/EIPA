function [] = EIPA(unequalnxny,negtworegionspace)
nx = 50;
ny = 50;

if unequalnxny == 1
    nx = nx + 5 + randi(10)
    ny = ny - 5 + randi(10)
end

G = sparse(nx*ny,nx*ny);

for i = 1:nx
    for j = 1:ny
        n = j + (i - 1) * ny;
        nxm = j + (i - 2) * ny;
        nxp = j + i * ny;
        nym = (j - 1) + (i - 1) * ny;
        nyp = (j + 1) + (i - 1) * ny;
        if i == 1 || i == nx || j == 1 || j == ny
            G(n,n) = 1;
        else
            G(n,n) = -4;
            if negtworegionspace == 1 && i > 10 && i < 20 && j > 10 && j < 20
                G(n,n) = -2;
            end
            G(n,nxm) = 1;
            G(n,nxp) = 1;
            G(n,nym) = 1;
            G(n,nyp) = 1;
        end
    end
end

figure(1)
spy(G)
[E,D] = eigs(G,9,'SM');

figure(2)
plot(diag(D))

for h = 1:9
    EV = zeros(nx,ny);
    for i = 1:nx
        for j = 1:ny
            n=j+(i-1)*ny;
            EV(i,j) = E(n,h);
        end
    end
    figure(h+2)
    surf(EV)
end

nx
ny