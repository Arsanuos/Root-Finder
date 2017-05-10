function [table] = Newton(fn, dfn, intialGuess, tolerance, iterations)
    fnc = inline(fn);
    dfnc = inline(dfn);
    iteration = 1;
    firstTime = tic;
    x(iteration) = intialGuess;
    f(iteration) = fnc(x(iteration));
    er(iteration) = 0;
    dfdx(iteration) = dfnc(x(iteration));
    table(iteration, 1) = iteration;
    table(iteration, 3) = x(iteration);
    table(iteration, 4) = f(iteration);
    table(iteration, 5) = dfdx(iteration);
    table(iteration, 6) = er(iteration);
    table(iteration, 2) = toc(firstTime);
    iteration = iteration + 1;
    for i = 2 : iterations
        firstTime = tic;
        x(i) = x(i - 1) - (f(i - 1) / dfdx(i - 1));
        f(i) = fnc(x(i));
        dfdx(i) = dfnc(x(i));
        er(i) = abs(x(i) - x(i - 1));
        table(i, 1) = i;
        table(i, 2) = toc(firstTime);
        table(i, 3) = x(iteration);
        table(i, 4) = f(iteration);
        table(i, 5) = dfdx(iteration);
        table(i, 6) = er(iteration);
        if er(i) < tolerance
           disp('Finished');
           break;
        end
        iteration = iteration + 1;
    end
    n = length(x);
    k = 1:n;
	time = 0;
    disp(table);
    fileID = fopen('outputNewton.txt','wt');
    fprintf(fileID,'%10s %12s %12s %12s %30s %15s\r\n','iterations', 'time', 'x','f','df/dx', 'Error');
       for i = 1:size(table)
          fprintf(fileID,'%10f %12f %15f %19f %23f %12f\r\n',table(i,:));
       end
    fclose(fileID);
    %disp('  step                    x                       f                    df/dx            Approximate Error %');
    %out = [k; x; f; dfdx; er*100];
    %fprintf('%5.0f      %20.14f     %21.15f     %21.15f     %20.14f \n',out);
    