
% QUESTAO 3
% ITEM a

% parametros iniciais
s = tf('s');

mc1 = 0.778;
mw1 = 4*0.500;
m1 = mc1 + mw1;

c1 = 2.94;
kv = 0.005;
khw = 14732;

k1 = 338.6;
deltak1 = 361.4;

% Gps eh a funcao de transferencia da "planta compensada" para o problema servo
% GpsDelta eh Gps*, a funcao de transferencia para o valor perturbado
Gps = khw / (m1*s^2 + (c1+khw*kv)*s + k1);
GpsDelta = khw / (m1*s^2 + (c1+khw*kv)*s + (k1 + deltak1));

display(tf(Gps));
display(tf(GpsDelta));

% ganhos de baixa frequencia
Gps0 = dcgain(Gps);
Gps0Delta = dcgain(GpsDelta);

display(Gps0);
display(Gps0Delta);

% ITEM b
Gpr = 1 / (m1*s^2 + (c1+khw*kv)*s + k1);
GprDelta = 1 / (m1*s^2 + (c1+khw*kv)*s + (k1 + deltak1));

display(tf(Gpr));
display(tf(GprDelta));

Gpr0 = dcgain(Gpr);
Gpr0Delta = dcgain(GprDelta);

display(Gpr0);
display(Gpr0Delta);

% ITEM c
display(Gps0Delta - Gps0);
display(Gpr0Delta - Gpr0);

% ITEM d
Gpf = 1;
kp = 0.12;

Ga = Gpf * Gps;
GaDelta = Gpf * GpsDelta;

Gf = Gpf * feedback(Gps * kp, 1);
GfDelta = Gpf * feedback(GpsDelta * kp, 1);

display(tf(Ga));
display(tf(GaDelta));
display(tf(Gf));
display(tf(GfDelta));

% ITEM e
Ea = (1 - Ga);
EaDelta = (1 - GaDelta);
Ef = (1 - Gf);
EfDelta = (1 - GfDelta);

eRegA = dcgain(Ea);
eRegADelta = dcgain(EaDelta);
eRegF = dcgain(Ef);
eRegFDelta = dcgain(EfDelta);

display(eRegA);
display(eRegADelta);
display(eRegF);
display(eRegFDelta);

% ITEM f
[stepGa, tA] = step(Ga, 1.2);
[stepGaDelta, tADelta] = step(GaDelta, 1.2);
[stepGf, tF] = step(Gf, 1.2);
[stepGfDelta, tFDelta] = step(GfDelta, 1.2);

degrauA = ones(length(stepGa), 1);
degrauF = ones(length(stepGf), 1);

figure, plot(tA, degrauA, tA, stepGa, tADelta, stepGaDelta);
title('Malha aberta');
legend('degrau', 'k1', 'k1*', 'Location', 'northwest');

figure, plot(tF, degrauF, tF, stepGf, tFDelta, stepGfDelta);
title('Malha fechada');
legend('degrau', 'k1', 'k1*', 'Location', 'southeast');

% QUESTAO 4
kpfA = 1 / Gps0;
GaZeroErr = kpfA * Gps;
EaZeroErr = (1 - GaZeroErr);
eRegAZeroErr = dcgain(EaZeroErr);

display(eRegAZeroErr);

% QUESTAO 5
kpfF = (1 + kp * Gps0) / (kp * Gps0);
GfZeroErr = kpfF * feedback(Gps * kp, 1);
EfZeroErr = (1 - GfZeroErr);
eRegFZeroErr = dcgain(EfZeroErr);

display(eRegFZeroErr);
