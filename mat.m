clear
clc
format long
h=600; b=300; h0=h-40;
fc=13.4; ft=1.54; As1=157; As2=804; Es=200000; Ec=25500;
s=0.000005:0.000005:0.0038;
n=50;
for i = 1:760
    x(1) = 0; x(2) = h0; x(3) = 0.5*h0;
    for j = 3:300
        hs = x(j)/n;
        hx = (h-x(j))/n;
        c = 0; t = 0; mcc = 0; mct = 0;
        strain1 = (x(j)-25)*s(i)/x(j);
        stress1 = fun1(strain1);
        strain2 = (h0-x(j))*s(i)/x(j);
        stress2 = fun1(strain2);
        for k = 1:n
            strainc(k) = (k-1/2)*hs*s(i)/x(j);
            stressc(k) = fun2(strainc(k));
            straint(k) = (k-1/2)*hx*s(i)/x(j);
            straint(k) = fun3(straint(k));
            c = c + stressc(k)*hs*b;
            t = t + stresst(k)*hx*b;
            mcc = mcc + stressc(k)*hs*b*(k-1/2)*hs;
            mct = mct + stresst(k)*hx*b*(k-1/2)*hx;
        end
        c = c + stress1*As1;
        t = t + stress2*As2;
        if abs(c-t)/c <= 0.001
            a(i) = s(i)/x(j);
            m1 = stress1*As1*(x(j)-25);
            m2 = stress2*As2*(h0-x(j));
            m(i) = mcc + mct + m1 + m2;
            break
        elseif c > t
            x(j-1) = min(x(j-2), x(j-1));
        else
            x(j-1) = max(x(j-2), x(j-1));
        end
            x(j+1) = (x(j-1) + x(j))/2;
    end
end

plot(1000*a, m/1000000); grid; xlabel('φ 单位：1/m'); ylabel('M 单位：kN*m'); title('M-φ 关系图')

        
