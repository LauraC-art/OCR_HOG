%nosotros
%Reconocimiento de caracteres usando Matlab

function [segments] = getSegments(grayImage,DEBUG)
    %% Valores por default
    if nargin<2, 
        DEBUG=0; 
    end;    
        
    %% Segmentación en regiones - Aquí empieza lo nuestro
%     %Se segmenta la imagen en regiones, idealmente las regiones encontradas
%     %son 2: el fondo y las letras mismas.
%     thresh = multithresh(grayImage,1);
%     
%     %La imagen segmentada contiene SÓLO valores 1 y 2
%     segmentedImage = imquantize(grayImage,thresh);
%     
%     %% corrección para binarización
%     %Se corrige la imagen Segmentada para que tengan valores de 1 y 0. es
%     %decir se "binariza"
%     segmentedImage = -1*(segmentedImage -2);
% 
%         %debug mode
%     if DEBUG == 1,
%         figure; imshow(segmentedImage)
%         title('Imagen en SIN bordes dilatados');        
%     end
%     
%     %% Dilatar regiones
%     dilateFactor=3;
%     se = strel('disk',dilateFactor);
%     dilatedImage = imdilate(segmentedImage,se);   
%     
%     %% Cerrar regiones
%     %Se cierran regiones.
%     closeFactor=4;
%     se = strel('disk',closeFactor);
%     closedImage = imclose(dilatedImage,se);    
% 
%     %% Erosion de regiones
%     %Se se erosiona la imagen.
%     erodeFactor=4;
%     se = strel('disk',erodeFactor);
%     erodedImage = imerode(closedImage,se);
% 
%     
%     %debug mode
%     if DEBUG == 1,
%         figure; imshow(erodedImage)
%         title('Imagen en con bordes erosionados');                
%     end
%     
%     %% Etiquetado de las regiones hallados
%     [regions, numObj] = bwlabel(erodedImage);
    %%Aquí termina nuestra parte de "main y separar"
    %%
    %MAIN.m NUESTRO SEPARAR
    
    % Read image
    imagen=grayImage;
    % Show image
    %imshow(imagen);
    %title('Imagen de entrada')
    % Convert to gray scale
%     if size(imagen,3)> 1 %Canales de color
%         imagen=rgb2gray(imagen);
%     end
    % Convert to BW
    threshold = graythresh(imagen);
    imagen =~imbinarize(imagen,threshold);
    % Remove all object containing fewer than 30 pixels
    imagen = bwareaopen(imagen,30);
    %Storage matrix word from image
    %word=[ ];
    re=imagen;

    %Opens text.txt as file for write
    %fid = fopen('text.txt', 'wt');
    % Load templates
    % load templates
    % global templates
    % % Compute the number of letters in template file
    % num_letras=size(templates,2);
    while 1
        %Fcn 'lines' separate lines in text
        [fl, re]= separar(re);
        imgn=fl;

        %Uncomment line below to see lines one by one
        %imshow(fl);pause(0.5)    
        %-----------------------------------------------------------------     
        % Label and count connected components
        [regions, numObj] = bwlabel(imgn);
        for n=1:numObj
            [r,c] = find(regions==n);
            % Extract letter
            n1=imgn(min(r):max(r),min(c):max(c));  
            % Resize letter (same size of template)
            %img_r=imresize(n1,[128 64]);
            %Uncomment line below to see letters one by one
            %imshow(img_r);pause(0.5)

            %APLICAR HOG
            %Enviar el HOG a la función para la regresión y se compara con los
            %HOG del dataset original
            %Sí es 3 o no :v
            %-------------------------------------------------------------------
        end

        %*When the sentences finish, breaks the loop
        if isempty(re)  %See variable 're' in Fcn 'lines'
            break
        end    
    end    
    %% de getSegments: Se obtiene el Bounding Box de las regiones conectadas, se queda añadirle este
    bBox = regionprops(regions, 'BoundingBox');

    
    %debug mode
    if DEBUG == 1,
        figure; imshow(regions)
        title('Regiones halladas');        
        hold on
    end

    %% Se llena la estructura de regiones encontradas, se queda
    for k = 1 : numObj
        %se obtiene la región de imagen segmentada
        segments(k).image = regions( ...
            ceil(bBox(k).BoundingBox(1,2)) : floor(bBox(k).BoundingBox(1,2)) + floor(bBox(k).BoundingBox(1,4)), ...
            ceil(bBox(k).BoundingBox(1,1)) : floor(bBox(k).BoundingBox(1,1)) + floor(bBox(k).BoundingBox(1,3)));
        %se obtiene el centro
        segments(k).center = ceil(size(segments(k).image)/2);
        segments(k).bBox = bBox(k).BoundingBox;
        %se obtiene el tamaño
        segments(k).size = size(segments(k).image);
        
        %debug mode
        if DEBUG == 1,
            rectangle('Position', bBox(k).BoundingBox,'EdgeColor','y');
        end
    end

    %debug mode
    if DEBUG == 1, 
        hold off
    end

end