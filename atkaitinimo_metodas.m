% Atkaitinimo modeliavimo metodas

T = 100 % pradine temperatura
x = [-5 5] % pradinis taskas
maxit = 50 % maksimalus iteraciju sk.
k = 1 % bolcmano konstanta
ausinimas = 0.4 % ausinimo koeficientas

tf = @(x) (x(1)+2.*x(2)-7).^2+(2.*x(1)+x(2)-5).^2; % tikslo funkcija
f = tf(x);

xgeriausias = x;

X = [-0.5 0 0.5 1 1.5 2 2.5]; % grafiko piesimas
Y = [0 1 2 3 4 5 6];
[X,Y] = meshgrid(X,Y);
Z = (X+2.*Y-7).^2+(2.*X+Y-5).^2;
contour(X,Y,Z);
hold on;

for i = 1:maxit
    xi = xgeriausias+rand()-0.5; % generuojamas atsitiktinis naujas x
    xi = max(min(xi,3.0),-3.0); % uztikrinama, kad jo reiksme yra nustatytose ribose (-3:3)
    deltaE = xi-x; % skaiciuojamas energijos skirtumas
    
    if (tf(xi) > f) % tikrinama, ar nauja funkcijos reiksme blogesne
      p=exp(-deltaE / k*T) %  jei taip, skaiciuojamas p 
      if(rand() > p) % tikrinama, ar atsitiktinis skaicius geresnis uz p
      atspriimtas = true % jei taip, nauja reiksme priimama
    else
      atspriimtas = false % jei ne, atmetamas
    end
  else
    atspriimtas = true % jei funkcijos reiksme geresne, reiksme priimama
  end
  
  if (atspriimtas == true)
    xgeriausias = xi; % jei atsakymas priimamas, naujas x tampa geriausiu
    f = tf(xgeriausias); % apskaiciuojama tikslo funkcija su geriausiu x
  endif
  plot(xgeriausias(1), xgeriausias(2), 'bo'); % grafike pavaizduojami taskai
  refresh;
endfor

T = T * ausinimas % temperatura mazinama pagal ausinimo koeficienta

disp(strcat('Funkcijos reiksme:', num2str(tf(xgeriausias)))); % atspausdinami rezultatai
disp(strcat('Minimumo taskas: [', num2str(xgeriausias),']'));
