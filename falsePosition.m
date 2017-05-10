function [table] = falsePosition( funcStr,xl,xu,tolerance,maxIterations)
%{
matrix(1)iterations
(2) xl
(3) xu
(4) xr
(5) f(xl)
(6) f(xu)
(7) f(xr)
(8) error
(9) time for all iterations from the start
%}
    xLower=xl;
    xUpper=xu;
    converter='@(x)';
    fallStr=strcat(converter,funcStr);
    func = str2func(fallStr);
    fXu=func(xUpper);
    fXl=func(xLower);
    flag=1;
    if (fXu*fXl>0)
        table='False position can not solve this problem.';
    else
          tic;
          previous=(xLower*fXu-xUpper*fXl)/(fXu-fXl); 
          time=toc;
          iterations=1;
          matrix=[iterations,xLower,xUpper,previous,fXl,fXu,func(previous),previous ,time];
    
    error=1000;
    while(abs(error)>tolerance&&iterations<maxIterations&&flag==1)
        if (func(previous)*fXu<0)
            xLower=previous;
            fXl=func(xLower);
        else
            xUpper=previous;
            fXu=func(xUpper);
        end
        if (fXu-fXl==0)
            flag=0;
            table='False position can not solve this problem.';
        else
         xr=(xLower*fXu-xUpper*fXl)/(fXu-fXl);
         time=toc;
         error=xr-previous;
         previous=xr;
         iterations=iterations+1;
         help=[iterations,xLower,xUpper,previous,fXl,fXu,func(previous),error,time];
         matrix=[matrix ; help];
        end
         
    end
    if (flag==1)
        table=matrix;
         fileID = fopen('outputFalsePosition.txt','wt');
         fprintf(fileID,'%10s %15s %12s %12s %14s %12s %12s %12s %18s\r\n','iterations', 'xl', 'xu','xr','f(xl)',' f(xu)','f(xr)',' error','time');
         for i = 1:size(table)
            fprintf(fileID,'%10f %20f %12f %12f %12f %12f %12f %15s %19s\r\n',table(i,:));
         end
         fclose(fileID);
    end
    
    end
end

