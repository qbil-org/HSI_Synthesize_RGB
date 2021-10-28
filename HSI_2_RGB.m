function [RGBImage] = HSI_2_RGB(HyperCube,wave)
    wl=length(wave);
    RGB = zeros(wl,3); 
    %Generate color mapping function matrix
    for i=1:1:wl
        % red color mapping function matrix
        if wave(i) <380
            RGB(i,1)=0;
        elseif wave(i)<=400
            RGB(i,1)=0.05-0.05*sin(pi*(wave(i)-366)/33);
        elseif wave(i)<=435 
            RGB(i,1) = 0.31*sin(pi*(wave(i)-395)/81);
        elseif wave(i)<=460
            RGB(i,1)=0.31*sin(pi*(wave(i)-412)/48);
        elseif wave(i)<=540
            RGB(i,1) = 0;
        elseif wave(i)<=590
            RGB(i,1) = 0.7*sin(pi*(wave(i)-540)/104); %originally 0.99*sin, change to 0.9
        elseif wave(i)<=670
            RGB(i,1) = 0.71*sin(pi*(wave(i)-507)/182); % originally 1*sin,change to 0.91
        elseif wave(i)<=730
            RGB(i,1) = 0.23-0.23*sin(pi*(wave(i)-670)/128); 
        else
            RGB(i,1) = 0;
        end
        % green color mapping function matrix
        if wave(i)<=454
            RGB(i,2) = 0;
        elseif wave(i)<617
            RGB(i,2) = 0.78*sin(pi*(wave(i)-454)/163); % ORIGINALLY 0.78*sin
        else
            RGB(i,2) = 0;
        end
        % blue color mapping function matrix
        if wave(i)<380 
            RGB(i,3) = 0;
        elseif wave(i)<400
            RGB(i,3) = 0.14-0.14*sin(pi*(wave(i)-364)/ 35);
        elseif wave(i)<445
            RGB(i,3) = 3.2*sin(pi*(wave(i)-395)/104); %originally 0.96*sin
        elseif wave(i)<510
            RGB(i,3) = 3.2*sin(pi*(wave(i)-377)/133); %originally 0.96*sin
        else
            RGB(i,3) = 0;
        end
    end
    % Transfer HSI to RGB
    RGBImage=zeros(size(HyperCube,1),size(HyperCube,2),3);
    for i=1:wl
        RGBImage(:,:,1) = RGBImage(:,:,1) + HyperCube(:,:,i)*RGB(i,1);
        RGBImage(:,:,2) = RGBImage(:,:,2) + HyperCube(:,:,i)*RGB(i,2);
        RGBImage(:,:,3) = RGBImage(:,:,3) + HyperCube(:,:,i)*RGB(i,3);
    end
    RGBImage = 5*RGBImage / wl;
    
%     for i=1:size(RGBImage,1)
%         for j=1:size(RGBImage,2)
%             if sum(RGBImage(i,j,:))>1.2
%                 RGBImage(i,j,:)=[0 0 0];
%             end
%         end
%     end

    figure(); imshow(RGBImage); 
%     title('RGB image generated from hypercube')
end

