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