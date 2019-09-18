# PS-RANSAC 
<h2>Non-ideal iris segmentation using Polar Spline RANSAC</h2>

Source code for estimating the external iris boundary in non-ideal ocular images.

We propose a robust iris segmentation method for non-ideal ocular images, referred to as Polar Spline RANSAC (PS-RANSAC), which approximates the iris shape as a closed curve with arbitrary degrees of freedom. The method is robust to several nonidealities, such as poor contrast, occlusions, gaze deviations, pupil dilation, motion blur, poor focus, frame interlacing, differences in image resolution,
specular reflections, and shadows. Unlike most techniques in the literature, the proposed method obtains good performance in harsh conditions with different imaging wavelengths and datasets.

<h3>Related publication</h3>
<p>
R. Donida Labati, E. Muñoz, V. Piuri, A. Ross, F. Scotti, "Non-ideal iris segmentation using Polar Spline RANSAC and illumination compensation", in Computer Vision and Image Understanding, Elsevier, 2019.<br>
DOI: 10.1016/j.cviu.2019.07.007
</p>

<h3>Citation</h3>
<p>
@Article {cviu2019,<br>
  &nbsp;&nbsp;author = {R. {Donida Labati}, E. Mu\~{n}oz, V. Piuri, A. Ross, F. Scotti},<br>
  &nbsp;&nbsp;title = {Non-ideal iris segmentation using Polar Spline RANSAC and illumination compensation},<br>
  &nbsp;&nbsp;publisher = {Elsevier},<br>
  &nbsp;&nbsp;journal = {Computer Vision and Image Understanding},<br>
  &nbsp;&nbsp;year = {2019},<br>
  &nbsp;&nbsp;doi = {10.1016/j.cviu.2019.07.007}<br>
}
</p>

<h3>Requirements</h3>
RANSAC Toolbox by Marco Zuliani
http://tinyurl.com/7x3k5av

<h3>Installation procedure</h3>
1) Unzip PS-RANSAC code in the directory "X".
2) Unzip the RANSAC Toolbox inside the directory X of PS-RANSAC, obtaining the subdirectory "X\RANSAC-Toolbox-master\".

<h3>Main file</h3>
main_demo.m

<h3>Contacts</h3>
Ruggero Donida Labati
Università degli Studi di Milano
http://www.di.unimi.it/donida
ruggero AT donida DOT unimi DOT it

