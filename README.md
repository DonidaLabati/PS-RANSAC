# PS-RANSAC 
<h2>Non-ideal iris segmentation using Polar Spline RANSAC</h2>

Source code for estimating the external iris boundary in non-ideal ocular images.

We propose a robust iris segmentation method for non-ideal ocular images, referred to as Polar Spline RANSAC (PS-RANSAC), which approximates the iris shape as a closed curve with arbitrary degrees of freedom. The method is robust to several nonidealities, such as poor contrast, occlusions, gaze deviations, pupil dilation, motion blur, poor focus, frame interlacing, differences in image resolution,
specular reflections, and shadows. Unlike most techniques in the literature, the proposed method obtains good performance in harsh conditions with different imaging wavelengths and datasets.

<h3>How to use the software library</h3>
The user should select 4 points of the internal iris boundary to allow the software estimating a circle approximating the internal iris boundary.
The software computes the external iris boundary using PS-RANSAC.


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

<h3>Credits</h3>
RANSAC Toolbox by Marco Zuliani<br>
https://github.com/RANSAC/RANSAC-Toolbox

circfit() by Izhak Bucher
https://it.mathworks.com/matlabcentral/fileexchange/5557-circle-fit?focused=5059278&tab=function

<h3>Main file</h3>
main_demo.m

<h3>Contacts</h3>
Ruggero Donida Labati<br>
Università degli Studi di Milano<br>
http://www.di.unimi.it/donida<br>
ruggero AT donida DOT unimi DOT it


<h3>External links</h3>
<h4>Enhancement</h4>
Bilateral filter<br>
https://it.mathworks.com/matlabcentral/fileexchange/12191-bilateral-filtering<br>
<h4>Iris boundaries</h4><br>
USIT Version 2<br>
http://www.wavelab.at/sources/Rathgeb16a/<br>
Osiris 4.1<br>
http://svnext.it-sudparis.eu/svnview2-eph/ref_syst/Iris_Osiris_v4.1/<br>
An Accurate Iris Segmentation Framework under Relaxed Imaging Constraints using Total Variation Model<br>
https://www4.comp.polyu.edu.hk/~csajaykr/tvmiris.htm<br>
Iris segmentation using Daugman's integrodifferential operator<br>
https://it.mathworks.com/matlabcentral/fileexchange/15652-iris-segmentation-using-daugman-s-integrodifferential-operator<br>
Masek's library<br>
https://www.peterkovesi.com/studentprojects/libor/<br>
<h4>Illumination compensation</h4>
The INface toolbox v2.0 for illumination invariant face recognition<br>
https://it.mathworks.com/matlabcentral/fileexchange/26523-the-inface-toolbox-v2-0-for-illumination-invariant-face-recognition




