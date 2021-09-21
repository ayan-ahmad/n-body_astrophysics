function [body] = parameters(m,p,v)
    body.mass=m;
    body.pos=p;
    body.velocity=v; 
    body.acceleration=[0 0];
    body.force=[0 0];
end