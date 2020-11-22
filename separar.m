function [fl re]=lines(im_texto)

%Aquí recibe la imagen normal, sin cortar ni nada
%Aquí iba eso de clip
im_texto=clipear(im_texto);

num_filas=size(im_texto,1);

for s=1:num_filas %Recorrer todas las filas
    if sum(im_texto(s,:))==0 %Si la sumatoria es igual a 0 en ese renglón (filas y columnas)
        nm=im_texto(1:s-1, :); % First line matrix
        rm=im_texto(s:end, :);% Remain line matrix
        fl = clipear(nm);
        re=clipear(rm);
        %*-*-*Uncomment lines below to see the result*-*-*-*-
        %         subplot(2,1,1);imshow(fl);
        %         subplot(2,1,2);imshow(re);
        break
    else
        fl=im_texto;%Only one line.
        re=[ ];
    end
end
function img_out=clipear(img_in)
[f c]=find(img_in);
img_out=img_in(min(f):max(f),min(c):max(c));%Crops image
%Aquí también iba eso de clip que le quita esos espacios pailas