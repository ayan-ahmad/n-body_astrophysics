% Ayan (2K19/EP/027) and Manu (2K19/EP/050) - CM MTE Project
% Numerical Analysis and Computational Simulations of CPS

clc;
clear;

op=input('Enter the case you wish you simulate: ')

switch op
  case 1
    % Appreciable Stability: Multi-Planet System (Sidenote: Body Pairs Method)
    body(1) = parameters(8 * 10^29, [-26.91*10^6 0], [0 -480000]);
    body(2) = parameters(3.285 * 10^24, [57.91*10^6 0], [0 480000]);
    body(3) = parameters(4.870 * 10^24, [1.082*10^7 0], [0 350000]);
  case 2
    % Extreme Unstability: Circumbinary Planet System (Ejection)
    body(1) = parameters(0.654*1.989*10^30, [-0.224*1.5*10^8], [0 -2.70000]);
    body(2) = parameters(0.1959*1.989*10^29, [0.224*1.5*10^8], [0 500000]);
    body(3) = parameters(0.333*1.898*10^27, [0.7048*1.5*10^8], [30000 30000]);
  case 3
    % Intermediate Stability: Circumbinary Planet System (Ejection)
    body(1) = parameters(0.654*1.989*10^30, [-0.224*1.5*10^8], [0 -400000]);
    body(2) = parameters(0.1959*1.989*10^29, [0.224*1.5*10^8], [0 500000]);
    body(3) = parameters(0.333*1.898*10^27, [0.7048*1.5*10^8], [3500 3300]);
  case 4
    % High Unstability: Circumbinary Planet System (Long term Ejection)
    body(1) = parameters(0.654*1.989*10^30, [-0.224*1.5*10^8], [0 -400000]);
    body(2) = parameters(0.1959*1.989*10^29, [0.224*1.5*10^8], [0 500000]);
    body(3) = parameters(0.333*1.898*10^25, [0.7048*1.5*10^8], [3500 3300]);
  case 5
    % High Unstablility: Circumbinary Planet System (Instant Ejection)
    body(1) = parameters(0.654*1.989*10^30, [-0.224*1.5*10^8], [0 -400000]);
    body(2) = parameters(0.1959*1.989*10^30, [0.224*1.5*10^8], [0 500000]);
    body(3) = parameters(0.333*1.898*10^27, [0.7048*1.5*10^8], [3500 3300]);
end

dt = 0.5;
step = 1000000;

spot=plot([],[]);
xlim([-5*10^8 5*10^8]);
ylim([-1*10^9 5*10^8]);
grid on; 
hold on;

for i = 0:step
    body = change(body,dt);
    if mod(i,25)==0
        orient = reshape([body.pos],[2,3]);
        drawnow;
        plot(orient(1,:),orient(2,:),'.','MarkerSize',10,'Color',[.10 .50 .50])
        xlabel('x position')
        ylabel('y position')
        grid on;
        delete(spot);
        spot = plot(orient(1,:),orient(2,:),'r.','MarkerSize',20);
    end    
end

function [body] = parameters(m,p,v)
    body.mass=m;
    body.pos=p;
    body.velocity=v; 
    body.acceleration=[0 0];
    body.force=[0 0];
end

function body = change(body, dt)
   G=6.67408*10^-11;
   for i=1:3
        for j=1:3
            if i==j
                continue
            end
            r=body(i).pos-body(j).pos;
            R=norm(r);
            f=-(G*body(i).mass*body(j).mass)/(R^2);
            body(i).force=body(i).force+f.*(r./R); 
        end
        body(i).acceleration=body(i).force./body(i).mass;
        body(i).velocity=body(i).velocity+body(i).acceleration.*dt;
        body(i).pos=body(i).pos+body(i).velocity.*dt;
        body(i).force=[0,0];
    end
end