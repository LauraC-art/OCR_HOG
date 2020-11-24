%clc, close all;
addpath('C:\Users\USER\Documents\Uni\Imágenes\OCR\proyecto\TEST');
% Read image
imagen=imread('TEST/TEST_1.jpg');
% Show image
imshow(imagen);
title('Imagen de entrada')
% Convert to gray scale
if size(imagen,3)> 1 %Canales de color
    imagen=rgb2gray(imagen);
end
% Convert to BW
threshold = graythresh(imagen);
imagen =~im2bw(imagen,threshold);
% Remove all object containing fewer than 30 pixels
imagen = bwareaopen(imagen,30);
%Storage matrix word from image
word=[ ];
re=imagen;

%Opens text.txt as file for write
fid = fopen('text.txt', 'wt');
% Load templates
% load templates
% global templates
% % Compute the number of letters in template file
% num_letras=size(templates,2);
while 1
    %Fcn 'lines' separate lines in text
    [fl re]= separar(re);
    imgn=fl;
    
    %Uncomment line below to see lines one by one
    %imshow(fl);pause(0.5)    
    %-----------------------------------------------------------------     
    % Label and count connected components
    [L Ne] = bwlabel(imgn);
    for n=1:Ne
        [r,c] = find(L==n);
        % Extract letter
        n1=imgn(min(r):max(r),min(c):max(c));  
        % Resize letter (same size of template)
        img_r=imresize(n1,[128 64]);
        %Uncomment line below to see letters one by one
        imshow(img_r);pause(0.5)
        
        %APLICAR HOG
        %Enviar el HOG a la función para la regresión y se compara con los
        %HOG del dataset original
        %Sí es 3 o no :v
        %-------------------------------------------------------------------
        % Call fcn to convert image to text
        
        %letter=read_letter(img_r,num_letras);
        
        % Letter concatenation
        
        %word=[word letter];
    end
    %fprintf(fid,'%s\n',lower(word));%Write 'word' in text file (lower)
    
    %fprintf(fid,'%s\n',word);%Write 'word' in text file (upper)
    
    % Clear 'word' variable
    
    %word=[ ];
    
    %*When the sentences finish, breaks the loop
    if isempty(re)  %See variable 're' in Fcn 'lines'
        break
    end    
end
% fclose(fid);
% %Open 'text.txt' file
% winopen('text.txt')
% fprintf('For more information, visit: <a href= "http://www.matpic.com">www.matpic.com </a> \n')
% clear all