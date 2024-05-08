function FuncFunciones = funciones

FuncFunciones.Lectura_Jose = @Lectura_Jose;
FuncFunciones.Lectura = @Lectura;
FuncFunciones.Media = @Media;

end

function [timeRe, Re, Nu_inst, fr_inst, NuGn, fr_blasius] = Lectura_Jose(variable)

a=readmatrix(append('friction_', variable));
tfr = a(:,1);

%eliminate duplicates (from restarts)

[tfr i j] = unique(tfr,'first');

fr = a(:,5);
fr =  fr(find(ismember(1:numel(fr),i)));

a=readmatrix(append('Nusselt_',variable));
tNu = a(:,1);

%eliminate duplicates (from restarts)

[tNu i j] = unique(tNu,'first');

Nu = a(:,2);
Nu =  Nu(find(ismember(1:numel(Nu),i)));


a=readmatrix(append('Reynolds_',variable));
tRe = a(:,1);

%eliminate duplicates (from restarts)

[tRe i j] = unique(tRe,'first');

Re = a(:,2);
Re = Re(find(ismember(1:numel(Re),i)));
timeRe = linspace(tRe(1), tRe(end), length(tRe));
Re = spline(tRe, Re, timeRe);

%parameters of the simulation
Pr = 0.7;
Re_mean = 6400;

for m = 1:length(Re)
    f = 0.316*Re(m)^(-0.25);
    NuGn(m,:) = (f/8)*(Re(m)-1000)*Pr/(1+12.7*sqrt(f/8)*(Pr^(2/3)-1));
    fr_blasius(m,:)=0.079*Re(m)^(-0.25);
end

%Turn calculated data into quasi-steady data

%First interpolate data to have the same extent as Reynolds array

%Nu_interp = makima(tNu,Nu,tRe);
Nu_interp = spline(tNu,Nu,timeRe);
Nu_inst = Nu_interp;

fr_interp= spline(tfr,fr,timeRe);
fr_inst = fr_interp;

end

function [leyenda_acc] = Lectura(acc_dec_rate, ReMean)
for i = 1:length(acc_dec_rate)
    var_time = append('time_', acc_dec_rate(i));
    var_Nusselt = append('Nusselt_', acc_dec_rate(i));
    var_Reynolds = append('Reynolds_', acc_dec_rate(i));
    var_friction = append('friction_', acc_dec_rate(i));
    var_friction_blasius = append('friction_blasius_', acc_dec_rate(i));
    var_Nusselt_Gieninski = append('Nusselt_Gieninski_', acc_dec_rate(i));
    var_Mean6400 = append('PosReMean6400_',acc_dec_rate(i));
    var_MeanX = append('PosReMeanX_',acc_dec_rate(i));
    [time, Reynolds, Nusselt, friction, Nu_Gieninski, Fr_Blasius] = Lectura_Jose(char(acc_dec_rate(i)));
    for m = 1:length(Reynolds)
        if (Reynolds(m) >= 9600)
            position = m;
            clear m;
            break;
        end
    end
    for m = 1:length(Reynolds)
        if (mean(Reynolds(1:m)) >= ReMean)
            position_time = m;
            clear m;
            break;
        end
    end
    assignin('base',char(var_time),time);
    assignin('base',char(var_Nusselt),Nusselt);
    assignin('base',char(var_Reynolds),Reynolds);
    assignin('base',char(var_friction),friction);
    assignin('base',char(var_Mean6400),position);
    assignin('base',char(var_MeanX), position_time);
    assignin('base',char(var_Nusselt_Gieninski), Nu_Gieninski);
    assignin('base', char(var_friction_blasius), Fr_Blasius);
    leyenda_acc(i) = {append('$\alpha$ = ', char(acc_dec_rate(i)))};
    clear time;
    clear Nusselt;
    clear Reynolds;
    clear position;
    clear position_time;


end
end

function [Delta_Nu, media] = Media(Reynolds, Nusselt, Reynolds_quasi, Nusselt_quasi, ReMean)
    
    for m = 1:length(Reynolds)
        if (mean(Reynolds(1:m)) >= ReMean)
            pos = m;
            clear m;
            break;
        end
    end
    media = mean(Nusselt(1:pos));
    for m = 1:length(Reynolds_quasi)
        if (mean(Reynolds_quasi(1:m)) >= ReMean)
            pos_quasi = m;
            clear m;
            break;
        end
    end
    Delta_Nu = ((mean(Nusselt(1:pos))-mean(Nusselt_quasi(1:pos_quasi)))/mean(Nusselt_quasi(1:pos_quasi)))*100;

end

