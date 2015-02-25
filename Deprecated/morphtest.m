%Used to test various bwmorph function options

file = 'data1/train1.jpg';

disp('Starting adapt. Please wait.');
ad = adapt(file);
disp('Adapt finished.');

morph = ad;

morph1 = bwmorph(morph,'open',1);
morph2 = bwmorph(morph,'open',2);

dif = morph2-morph1;

imshow(dif);

x = sum(sum(dif));

disp(x);