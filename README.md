# HSI-2-RGB
MATLAB code for HSI-2-RGB transformation

%%% HSI_2_RGB was customized for the live mice data and may work better on in vivo tissue. 
rgb = HSI_2_RGB(wavelengths, calibrated_hs_cube);


%%% HSI2RGB offers 2 versions of transformation for transmittance and reflectance, respectively
rgb = HSI2RGB(wavelengths, calibrated_hs_cube, option);
option = 't': transmittance (microscopic images)
option = 'r': reflectance (in vivio/ex vivo tissue images)

%%% Both transformations were synthesized using sin/cos functions. They can be customized to you data.
%%% Please cite either paper below for this HSI-2-RGB transformation:
%%% [1] Ling Ma, Ximing Zhou, James V. Little, Amy Y. Chen, Larry L. Myers, Baran D. Sumer, Baowei Fei, "Hyperspectral microscopic imaging for the detection of head and neck squamous %%% cell carcinoma on histologic slides," Proc. SPIE 11603, Medical Imaging 2021: Digital Pathology, 116030P (15 February 2021); https://doi.org/10.1117/12.2581970
%%% [2] Ling Ma, Martin Halicek, Ximing Zhou, James Dormer, Baowei Fei, "Hyperspectral microscopic imaging for automatic detection of head and neck squamous cell carcinoma using 
%%% histologic image and machine learning," Proc. SPIE 11320, Medical Imaging 2020: Digital Pathology, 113200W (16 March 2020); https://doi.org/10.1117/12.2549369
