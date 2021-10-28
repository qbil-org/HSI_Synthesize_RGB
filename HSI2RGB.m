function [RGB] = HSI2RGB(HyperCube,wave,rt)
% rt = reflectance or transmittance
    wl=length(wave);
    RGB = zeros(wl,3); 
    %Generate color mapping function matrix
    for i=1:1:wl
        
        % Reflectance
        if rt=='r'
            Multiply=1;
            % red color mapping function matrix
            if wave(i) <380
                RGB(i,1)=0;
            elseif wave(i)<=435 
                RGB(i,1) = 0.155*sin(2*pi*wave(i)/110+13*pi/22)+0.155;
            elseif wave(i)<=500
                RGB(i,1) = 0.155*sin(2*pi*wave(i)/130-5*pi/26)+0.155;
            elseif wave(i)<=590
                RGB(i,1) = 0.55*sin(2*pi*wave(i)/180-pi/18)+0.55; 
            elseif wave(i)<=720
                RGB(i,1) = 0.55*sin(2*pi*wave(i)/260-pi/26)+0.55; 
            else
                RGB(i,1) = 0;
            end
            % green color mapping function matrix
            if wave(i)<380
                RGB(i,2)=0;
            elseif wave(i)<=450
                RGB(i,2) = 0.025*sin(2*pi*wave(i)/140-83*pi/14)+0.025;
            elseif wave(i)<=560
                RGB(i,2) = 0.475*sin(2*pi*wave(i)/220+31*pi/22)+0.525;
            elseif wave(i)<=720
                RGB(i,2) = 0.5*sin(2*pi*wave(i)/320+pi)+0.5; 
            else
                RGB(i,2) = 0;
            end
            % blue color mapping function matrix
            if wave(i)<380 
                RGB(i,3) = 0;
            elseif wave(i)<440
                RGB(i,3) = 0.85*sin(2*pi*wave(i)/120-5*pi/6)+0.85;
            elseif wave(i)<470
                RGB(i,3) = 0.175*sin(2*pi*wave(i)/60-pi/6)+1.525; 
            elseif wave(i)<=550
                RGB(i,3) = 0.8*sin(2*pi*wave(i)/220+pi/2)+0.8; 
            else
                RGB(i,3) = 0;
            end
        elseif rt=='t'
            % RGB color modified for microscopic image
            %%%%%%%RED%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            Apeakr1=3; Apeakr2=3; 
            Ar1=Apeakr1/2; Ar2=Apeakr2/2; 
            %%%%%%%GREEN%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            Apeakg=2; 
            offsetg=0.05; Ag1=0.025; Ag2=(Apeakg-offsetg)/2; Ag3=Apeakg/2;
            %%%%%%%BLUE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            Apeakb1=22; Apeakb2=20; Apeakb3=22;
            Ab1=Apeakb1/2; Ab2=(Apeakb1-Apeakb2)/2; offsetb=Apeakb2; Ab3=Apeakb3/2;  
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            Multiply=0.9;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % Red
            if wave(i) <380
                RGB(i,1)=0;
            elseif wave(i)<=435 
                RGB(i,1) = Ar1 * sin(2*pi*wave(i)/110+13*pi/22)+Ar1;
            elseif wave(i)<=500
                RGB(i,1) = Ar1 * sin(2*pi*wave(i)/130-5*pi/26) +Ar1;
            elseif wave(i)<=590
                RGB(i,1) = Ar2 * sin(2*pi*wave(i)/180-pi/18)   +Ar2; 
            elseif wave(i)<=720
                RGB(i,1) = Ar2 * sin(2*pi*wave(i)/260-pi/26)   +Ar2; 
            else
                RGB(i,1) = 0;
            end
            % green color
            if wave(i)<380
                RGB(i,2)=0;
            elseif wave(i)<=450
                RGB(i,2) = Ag1*sin(2*pi*wave(i)/140-83*pi/14)+Ag1;
            elseif wave(i)<=560
                RGB(i,2) = Ag2*sin(2*pi*wave(i)/220+31*pi/22)+Ag2+offsetg;
            elseif wave(i)<=720
                RGB(i,2) = Ag3*sin(2*pi*wave(i)/320+pi)+Ag3; 
            else
                RGB(i,2) = 0;
            end
            % blue 
            if wave(i)<380 
                RGB(i,3) = 0;
            elseif wave(i)<440
                RGB(i,3) = Ab1*sin(2*pi*wave(i)/120-5*pi/6)+Ab1;
            elseif wave(i)<470
                RGB(i,3) = Ab2*sin(2*pi*wave(i)/60-pi/6)   +Ab2 + offsetb; 
            elseif wave(i)<=550
                RGB(i,3) = Ab3*sin(2*pi*wave(i)/220+pi/2)  +Ab3; 
            else
                RGB(i,3) = 0;
            end
        end  
    end
    % Transfer HSI to RGB
    RGBImage=zeros(size(HyperCube,1),size(HyperCube,2),3);
    for i=1:wl
        RGBImage(:,:,1) = RGBImage(:,:,1) + HyperCube(:,:,i)*RGB(i,1);
        RGBImage(:,:,2) = RGBImage(:,:,2) + HyperCube(:,:,i)*RGB(i,2);
        RGBImage(:,:,3) = RGBImage(:,:,3) + HyperCube(:,:,i)*RGB(i,3);
    end
    RGBImage = Multiply*RGBImage / wl;
    

    RGB = im2uint8(RGBImage);
    figure;imshow(RGB); title('Synthesized RGB in uint8');
% % % % % %     figure(); imshow(RGBImage); title('RGB image generated from hypercube')
end

