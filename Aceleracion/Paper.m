%% Reseto de memoria
clear all;
close all;
clc;

%% Data integration

% Adding Function Path
addpath('funciones/')

% Reading Files
Funcion = funciones;

% Datos de aceleracion
acc_dec_rate = {'0p00075','0p001', '0p0025', '0p005','0p0075', '0p01', '0p025', '0p05', '0p1', '0p5', '1'};
legend_function = {'o', '+', '*', 'x', 'square', 'diamond', '^', 'v', '<', 'pentagram', 'hexagram'};
alpha = [0.00075, 0.001, 0.0025, 0.005, 0.0075, 0.01, 0.025, 0.05, 0.1, 0.5, 1];
ReMean = 6400; % Maximo 7000 debido a alpha 0p00075

leyenda_acc = Funcion.Lectura(acc_dec_rate, ReMean);

%% Nusselt Mean, Reynolds = Variable

Reynolds_Mean_vector = [6400 6600 6800 7000 7200 7400];
for i = 1:length(Reynolds_Mean_vector)
    
    [Delta_Nu(1,i) Nusselt_mean(1,i)] = Funcion.Media(Reynolds_0p00075, Nusselt_0p00075, Reynolds_0p001, Nusselt_0p001, Reynolds_Mean_vector(i));
    [Delta_Nu(2,i) Nusselt_mean(2,i)] = Funcion.Media(Reynolds_0p001, Nusselt_0p001, Reynolds_0p001, Nusselt_0p001, Reynolds_Mean_vector(i));
    [Delta_Nu(3,i) Nusselt_mean(3,i)] = Funcion.Media(Reynolds_0p0025, Nusselt_0p0025, Reynolds_0p001, Nusselt_0p001, Reynolds_Mean_vector(i));
    [Delta_Nu(4,i) Nusselt_mean(4,i)] = Funcion.Media(Reynolds_0p005, Nusselt_0p005, Reynolds_0p001, Nusselt_0p001, Reynolds_Mean_vector(i));
    [Delta_Nu(5,i) Nusselt_mean(5,i)] = Funcion.Media(Reynolds_0p0075, Nusselt_0p0075, Reynolds_0p001, Nusselt_0p001, Reynolds_Mean_vector(i));
    [Delta_Nu(6,i) Nusselt_mean(6,i)] = Funcion.Media(Reynolds_0p01, Nusselt_0p01, Reynolds_0p001, Nusselt_0p001, Reynolds_Mean_vector(i));
    [Delta_Nu(7,i) Nusselt_mean(7,i)] = Funcion.Media(Reynolds_0p025, Nusselt_0p025, Reynolds_0p001, Nusselt_0p001, Reynolds_Mean_vector(i));
    [Delta_Nu(8,i) Nusselt_mean(8,i)] = Funcion.Media(Reynolds_0p05, Nusselt_0p05, Reynolds_0p001, Nusselt_0p001, Reynolds_Mean_vector(i));
    [Delta_Nu(9,i) Nusselt_mean(9,i)] = Funcion.Media(Reynolds_0p1, Nusselt_0p1, Reynolds_0p001, Nusselt_0p001, Reynolds_Mean_vector(i));
    [Delta_Nu(10,i) Nusselt_mean(10,i)] = Funcion.Media(Reynolds_0p5, Nusselt_0p5, Reynolds_0p001, Nusselt_0p001, Reynolds_Mean_vector(i));
    [Delta_Nu(11,i) Nusselt_mean(11,i)] = Funcion.Media(Reynolds_1, Nusselt_1, Reynolds_0p001, Nusselt_0p001, Reynolds_Mean_vector(i));

end

%% Apartado 3.1.1 
figure(1) % Reynolds vs Tiempo para alpha = 0p001 (Cuasi-Estacionario)
plot(time_0p005, Reynolds_0p005,'-', 'LineWidth',1.5,'Color','#00AB84')
x0 = xline(0,' ', 'Phase 1','FontAngle','italic','Color','#956C58');
x1 = xline(200,'--', 'Phase 2','FontAngle','italic','Color','#956C58','LineWidth',2);
legend(leyenda_acc(4), 'Interpreter','Latex','Location','northwest')
xlabel('$t$' , 'Interpreter', 'latex','FontSize',14)
ylabel('$Re$','Interpreter','latex','Rotation',0,'FontSize',14)
x0.LabelVerticalAlignment = 'middle';
x0.LabelHorizontalAlignment = 'right';
x0.LabelOrientation = 'horizontal';
x1.LabelVerticalAlignment = 'middle';
x1.LabelHorizontalAlignment = 'right';
x1.LabelOrientation = 'horizontal';
xlim([0 300])
print(gcf, './Graficas/reynoldsVStime.eps', '-depsc');



figure(2) %Nusselt Vs Time
plot(time_0p005, Nusselt_0p005, '-', 'LineWidth',1.5, 'Color','#00AB84')
xlabel('$t$' , 'Interpreter', 'latex','FontSize',14)
ylabel('$Nu$','Interpreter','latex','Rotation',0,'FontSize',14)
x0 = xline(0,' ', 'Phase 1','FontAngle','italic','Color','#956C58');
x1 = xline(57,'--', 'Phase 2','FontAngle','italic','Color','#956C58','LineWidth',2);
x2 = xline(225,'--','Phase 3','FontAngle','italic','Color','#956C58','LineWidth',2);
legend(leyenda_acc(4), 'Interpreter','Latex','Location','northwest');
x0.LabelVerticalAlignment = 'bottom';
x0.LabelHorizontalAlignment = 'right';
x0.LabelOrientation = 'horizontal';
x1.LabelVerticalAlignment = 'bottom';
x1.LabelHorizontalAlignment = 'right';
x1.LabelOrientation = 'horizontal';
x2.LabelVerticalAlignment = 'bottom';
x2.LabelHorizontalAlignment = 'right';
x2.LabelOrientation = 'horizontal';
xlim([0 300])
ylim([0 30])
print(gcf, './Graficas/nusseltVStime.eps', '-depsc');


figure(3) % Cf vs time
plot(time_0p005, friction_0p005, '-', 'LineWidth',1.5, 'Color','#00AB84')
xlabel('$t$' , 'Interpreter', 'latex','FontSize',14)
ylabel('$C_f$','Interpreter','latex','Rotation',0,'FontSize',14)
x0 = xline(0,' ', 'Phase 1','FontAngle','italic','Color','#956C58');
x0_0 = xline(5,'--', 'Phase 2','FontAngle','italic','Color','#956C58','LineWidth',2);
x1 = xline(57,'--', 'Phase 3','FontAngle','italic','Color','#956C58','LineWidth',2);
x2 = xline(100,'--','Phase 4','FontAngle','italic','Color','#956C58','LineWidth',2);
legend(leyenda_acc(4), 'Interpreter','Latex','Location','northeast');
x0.LabelHorizontalAlignment = 'right';
x0_0.LabelVerticalAlignment = 'bottom';
x0_0.LabelHorizontalAlignment = 'right';
x0_0.LabelOrientation = 'horizontal';
x1.LabelVerticalAlignment = 'bottom';
x1.LabelHorizontalAlignment = 'right';
x1.LabelOrientation = 'horizontal';
x2.LabelVerticalAlignment = 'bottom';
x2.LabelHorizontalAlignment = 'right';
x2.LabelOrientation = 'horizontal';
xlim([0 150])
ylim([0 0.015])
print(gcf, './Graficas/Cf.eps', '-depsc');

%% Nusselt
figure(20) % Nusselt vs Reynolds para alpha = 0p001 (Cuasi-Estacionario)
plot(Reynolds_0p001(1:PosReMean6400_0p001), Nusselt_0p001(1:PosReMean6400_0p001), '+','MarkerIndices',1:2000:length(Nusselt_0p001))
hold on
plot(Reynolds_0p001(1:PosReMean6400_0p001), Nusselt_Gieninski_0p001(1:PosReMean6400_0p001), '--', 'LineWidth',1.5, 'Color','#E0004D')
lgd4 = legend('$\alpha$ = 0.001' ,'Gnielinski Nusselt', 'Interpreter','Latex', 'Location', 'southeast');
lgd4.NumColumns = 1;
xlabel('$Re$' , 'Interpreter', 'latex','FontSize',14)
ylabel('$Nu$','Interpreter','latex','Rotation',0,'FontSize',14)
xlim([3200 9600])
ylim([0 30])
print(gcf, './Graficas/NuReynolds_0p001.eps', '-depsc');

figure(21) % Nusselt vs Reynolds para alpha = 0p5 (Limite Superior)
plot(Reynolds_0p5(1:PosReMean6400_0p5), Nusselt_0p5(1:PosReMean6400_0p5), 'pentagram','MarkerIndices',1:5:length(Nusselt_0p5))
hold on
plot(Reynolds_0p001(1:PosReMean6400_0p001), Nusselt_Gieninski_0p001(1:PosReMean6400_0p001), '--', 'LineWidth',1.5, 'Color','#E0004D')
lgd4 = legend('$\alpha$ = 0.5' ,'Gnielinski Nusselt', 'Interpreter','Latex', 'Location', 'southeast');
lgd4.NumColumns = 1;
xlabel('$Re$' , 'Interpreter', 'latex','FontSize',14)
ylabel('$Nu$','Interpreter','latex','Rotation',0,'FontSize',14)
xlim([3200 9600])
ylim([0 30])
print(gcf, './Graficas/NuReynolds_0p5.eps', '-depsc');

figure(22) % Nusselt vs Reynolds (Transicion desde el Cuasi-Estacionario hasta el Limite superior)
plot(Reynolds_0p001(1:PosReMean6400_0p001), Nusselt_0p001(1:PosReMean6400_0p001), '+','MarkerIndices',1:2000:length(Nusselt_0p001))
hold on
plot(Reynolds_0p0075(1:PosReMean6400_0p0075), Nusselt_0p0075(1:PosReMean6400_0p0075), '>','MarkerIndices',1:200:length(Nusselt_0p0075))
hold on
plot(Reynolds_0p01(1:PosReMean6400_0p01), Nusselt_0p01(1:PosReMean6400_0p01), 'square','MarkerIndices',1:100:length(Nusselt_0p01))
hold on
plot(Reynolds_0p5(1:PosReMean6400_0p5), Nusselt_0p5(1:PosReMean6400_0p5), 'pentagram','MarkerIndices',1:5:length(Nusselt_0p5))
hold on
plot(Reynolds_0p001(1:PosReMean6400_0p001), Nusselt_Gieninski_0p001(1:PosReMean6400_0p001), '--', 'LineWidth',1.5, 'Color','#E0004D')
lgd4 = legend([leyenda_acc(2), leyenda_acc(5), leyenda_acc(6), leyenda_acc(10) ,'Gnielinski Nusselt'], 'Interpreter','Latex', 'Location', 'southeast');
lgd4.NumColumns = 1;
xlabel('$Re$' , 'Interpreter', 'latex','FontSize',14)
ylabel('$Nu$','Interpreter','latex','Rotation',0,'FontSize',14)
xlim([3200 9600])
ylim([0 30])
print(gcf, './Graficas/NuReynolds_all.eps', '-depsc');


%% Friccion
figure(23) % Coeficiente de Friccion vs Reynolds para alpha = 0p001 (Cuasi-Estacionario)
plot(Reynolds_0p001(1:PosReMean6400_0p001), friction_0p001(1:PosReMean6400_0p001), '+','MarkerIndices',1:2000:length(friction_0p001))
hold on
plot(Reynolds_0p001(1:PosReMean6400_0p001), friction_blasius_0p001(1:PosReMean6400_0p001), '--', 'LineWidth',1.5, 'Color','#7A9A01')
lgd4 = legend('$\alpha$ = 0.001' ,'Blasius Friction', 'Interpreter','Latex', 'Location', 'southeast');
lgd4.NumColumns = 1;
xlabel('$Re$' , 'Interpreter', 'latex','FontSize',14)
ylabel('$C_f$','Interpreter','latex','Rotation',0,'FontSize',14)
xlim([3200 9600])
ylim([-0.005 0.035])
print(gcf, './Graficas/CfReynolds_0p001.eps', '-depsc');

figure(24) % Coeficiente de Friccion vs Reynolds para alpha = 0p5 (limite Superior)
plot(Reynolds_0p5(1:PosReMean6400_0p5), friction_0p5(1:PosReMean6400_0p5), 'pentagram','MarkerIndices',1:5:length(friction_0p5))
hold on
plot(Reynolds_0p001(1:PosReMean6400_0p001), friction_blasius_0p001(1:PosReMean6400_0p001), '--', 'LineWidth',1.5, 'Color','#7A9A01')
lgd4 = legend('$\alpha$ = 0.5' ,'Blasius Friction', 'Interpreter','Latex', 'Location', 'southeast');
lgd4.NumColumns = 1;
xlabel('$Re$' , 'Interpreter', 'latex','FontSize',14)
ylabel('$C_f$','Interpreter','latex','Rotation',0,'FontSize',14)
xlim([3200 9600])
ylim([-0.005 0.035])
print(gcf, './Graficas/CfReynolds_0p5.eps', '-depsc');

figure(25) % Coeficiente de Friccion vs Reynolds (Transicion desde el Cuasi-Estacionario hasta el Limite Superior)
plot(Reynolds_0p001(1:PosReMean6400_0p001), friction_0p001(1:PosReMean6400_0p001), '+','MarkerIndices',1:2000:length(friction_0p001))
hold on
plot(Reynolds_0p0075(1:PosReMean6400_0p0075), friction_0p0075(1:PosReMean6400_0p0075), '>','MarkerIndices',1:200:length(friction_0p0075))
hold on
plot(Reynolds_0p01(1:PosReMean6400_0p01), friction_0p01(1:PosReMean6400_0p01), 'square','MarkerIndices',1:100:length(friction_0p01))
hold on
plot(Reynolds_0p5(1:PosReMean6400_0p5), friction_0p5(1:PosReMean6400_0p5), 'pentagram','MarkerIndices',1:5:length(friction_0p5))
hold on
plot(Reynolds_0p001(1:PosReMean6400_0p001), friction_blasius_0p001(1:PosReMean6400_0p001), '--', 'LineWidth',1.5, 'Color','#7A9A01')
lgd4 = legend([leyenda_acc(2), leyenda_acc(5), leyenda_acc(6), leyenda_acc(10) ,'Blasius Friction'], 'Interpreter','Latex', 'Location', 'southwest');
lgd4.NumColumns = 1;
xlabel('$Re$' , 'Interpreter', 'latex','FontSize',14)
ylabel('$C_f$','Interpreter','latex','Rotation',0,'FontSize',14)
xlim([3200 9600])
ylim([-0.005 0.035])
print(gcf, './Graficas/CfReynolds_all.eps', '-depsc');

%% Nusselt Mean, Re = 6400
figure(26)
x6 = [alpha(2) alpha(3) alpha(4) alpha(5) alpha(6) alpha(7) alpha(8) alpha(9)];
y6 = [mean(Nusselt_0p001(1:PosReMean6400_0p001))...
     mean(Nusselt_0p0025(1:PosReMean6400_0p0025)) mean(Nusselt_0p005(1:PosReMean6400_0p005))...
     mean(Nusselt_0p0075(1:PosReMean6400_0p0075)) mean(Nusselt_0p01(1:PosReMean6400_0p01))...
     mean(Nusselt_0p025(1:PosReMean6400_0p025)) mean(Nusselt_0p05(1:PosReMean6400_0p05))...
     mean(Nusselt_0p1(1:PosReMean6400_0p1))];
h6 = logspace(-3,-1, 500);
v6 = interp1(x6, y6, h6, 'makima');
semilogx(alpha(1), mean(Nusselt_0p00075(1:PosReMean6400_0p00075)), 'o')
hold on
semilogx(alpha(2), mean(Nusselt_0p001(1:PosReMean6400_0p001)), '+')
hold on
semilogx(alpha(3), mean(Nusselt_0p0025(1:PosReMean6400_0p0025)), '*')
hold on
semilogx(alpha(4), mean(Nusselt_0p005(1:PosReMean6400_0p005)), 'x')
hold on
semilogx(alpha(5), mean(Nusselt_0p0075(1:PosReMean6400_0p0075)), '>')
hold on
semilogx(alpha(6), mean(Nusselt_0p01(1:PosReMean6400_0p01)), 'square')
hold on
semilogx(alpha(7), mean(Nusselt_0p025(1:PosReMean6400_0p025)), '|')
hold on
semilogx(alpha(8), mean(Nusselt_0p05(1:PosReMean6400_0p05)), 'diamond')
hold on
semilogx(alpha(9), mean(Nusselt_0p1(1:PosReMean6400_0p1)), '^')
hold on
semilogx(alpha(10), mean(Nusselt_0p5(1:PosReMean6400_0p5)), 'v')
hold on
semilogx(alpha(11), mean(Nusselt_1(1:PosReMean6400_1)), '<')
hold on
semilogx(h6(1:330), v6(1:330), '--', 'LineWidth',1.5, 'Color','#E0004D')
ylinefig6 = yline(mean(Nusselt_0p00075(1:PosReMean6400_0p00075)),'-.', 'LineWidth',1.5, 'Color','#956C58');
ylinefig61 = yline(mean(Nusselt_0p1(1:PosReMean6400_0p1)),'-.', 'LineWidth',1.5, 'Color','#956C58');
lgd6 = legend([leyenda_acc 'Interpolation'], 'Interpreter','Latex');
lgd6.NumColumns = 2;
xlabel('$\alpha$' , 'Interpreter', 'latex','FontSize',14)
ylabel('$Nu$','Interpreter','latex','Rotation',0,'FontSize',14)
xlim([0.0005 1])
print(gcf, './Graficas/NuMean6400.eps', '-depsc');

figure(27) % Delta Nu vs alpha
x7 = [alpha(2) alpha(3) alpha(4) alpha(5) alpha(6) alpha(7) alpha(8) alpha(9)];
Delta_Nu(1) = Funcion.Media(Reynolds_0p00075, Nusselt_0p00075, Reynolds_0p001, Nusselt_0p001, ReMean);
Delta_Nu(2) = Funcion.Media(Reynolds_0p001, Nusselt_0p001, Reynolds_0p001, Nusselt_0p001, ReMean);
Delta_Nu(3) = Funcion.Media(Reynolds_0p0025, Nusselt_0p0025, Reynolds_0p001, Nusselt_0p001, ReMean);
Delta_Nu(4) = Funcion.Media(Reynolds_0p005, Nusselt_0p005, Reynolds_0p001, Nusselt_0p001, ReMean);
Delta_Nu(5) = Funcion.Media(Reynolds_0p0075, Nusselt_0p0075, Reynolds_0p001, Nusselt_0p001, ReMean);
Delta_Nu(6) = Funcion.Media(Reynolds_0p01, Nusselt_0p01, Reynolds_0p001, Nusselt_0p001, ReMean);
Delta_Nu(7) = Funcion.Media(Reynolds_0p025, Nusselt_0p025, Reynolds_0p001, Nusselt_0p001, ReMean);
Delta_Nu(8) = Funcion.Media(Reynolds_0p05, Nusselt_0p05, Reynolds_0p001, Nusselt_0p001, ReMean);
Delta_Nu(9) = Funcion.Media(Reynolds_0p1, Nusselt_0p1, Reynolds_0p001, Nusselt_0p001, ReMean);
Delta_Nu(10) = Funcion.Media(Reynolds_0p5, Nusselt_0p5, Reynolds_0p001, Nusselt_0p001, ReMean);
Delta_Nu(11) = Funcion.Media(Reynolds_1, Nusselt_1, Reynolds_0p001, Nusselt_0p001, ReMean);
y7 = [Delta_Nu(2) Delta_Nu(3) Delta_Nu(4) Delta_Nu(5) Delta_Nu(6) Delta_Nu(7) Delta_Nu(8) Delta_Nu(9)];
h7 = logspace(-3,-1, 500);
v7 = interp1(x7, y7, h7, 'makima');
semilogx(alpha(1), Delta_Nu(1), 'o')
hold on
semilogx(alpha(2), Delta_Nu(2), '+')
hold on
semilogx(alpha(3), Delta_Nu(3), '*')
hold on
semilogx(alpha(4), Delta_Nu(4), 'x')
hold on
semilogx(alpha(5), Delta_Nu(5), '>')
hold on
semilogx(alpha(6), Delta_Nu(6), 'square')
hold on
semilogx(alpha(7), Delta_Nu(7), '|')
hold on
semilogx(alpha(8), Delta_Nu(8), 'diamond')
hold on
semilogx(alpha(9), Delta_Nu(9), '^')
hold on
semilogx(alpha(10), Delta_Nu(10), 'v')
hold on
semilogx(alpha(11), Delta_Nu(11), '<')
hold on
semilogx(h7(1:330), v7(1:330), '--', 'LineWidth',1.5, 'Color','#E0004D')
ylinefig7 = yline(Delta_Nu(1),'-.', 'LineWidth',1.5, 'Color','#956C58');
ylinefig71 = yline(Delta_Nu(9),'-.', 'LineWidth',1.5, 'Color','#956C58');
lgd6 = legend([leyenda_acc 'Interpolation'], 'Interpreter','Latex');
lgd6.NumColumns = 2;
xlabel('$\alpha$' , 'Interpreter', 'latex','FontSize',14)
ylabel('$\Delta_{Nu} [\%]$','Interpreter','latex','Rotation',0,'FontSize',14)
xlim([0.0005 1])
print(gcf, './Graficas/DeltaNu6400.eps', '-depsc');

%% Representacion de Nusselt Mean para varios Reynolds
figure(28)
for i = 1:length(Reynolds_Mean_vector) 
    semilogx(alpha, Nusselt_mean(:,i), char(legend_function(i)))
    hold on
    formatSpec = '$Re_{%d}$';
    leyenda_nueva_Re = sprintf(formatSpec, Reynolds_Mean_vector(i));
    leyenda_Re(i) = {leyenda_nueva_Re};
end
xlabel('$\alpha$' , 'Interpreter', 'latex','FontSize',14)
ylabel('$Nu$','Interpreter','latex','Rotation',0,'FontSize',14)
xlim([0.0005 1])
legend(leyenda_Re, 'Interpreter','Latex');
print(gcf, './Graficas/NuMean_all.eps', '-depsc');

figure(29)
for i = 1:length(Reynolds_Mean_vector) 
    semilogx(alpha, Delta_Nu(:,i), char(legend_function(i)))
    hold on
    formatSpec = '$Re_{%d}$';
    leyenda_nueva_Re = sprintf(formatSpec, Reynolds_Mean_vector(i));
    leyenda_Re(i) = {leyenda_nueva_Re};
end
xlabel('$\alpha$' , 'Interpreter', 'latex','FontSize',14)
ylabel('$\Delta_{Nu} [\%]$','Interpreter','latex','Rotation',0,'FontSize',14)
xlim([0.0005 1])
legend(leyenda_Re, 'Interpreter','Latex');
print(gcf, './Graficas/DeltaNu_all.eps', '-depsc');