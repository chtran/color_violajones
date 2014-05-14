ConvertHaarcasadeXMLOpenCV('HaarCascades/haarcascade_frontalface_alt.xml');
I = imread('Images/3.jpg');
FilenameHaarcasade = 'HaarCascades/haarcascade_frontalface_alt.mat';
Objects=ObjectDetection(I,FilenameHaarcasade);
ShowDetectionResult(I,Objects);