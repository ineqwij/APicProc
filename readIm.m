function im = readIm(path)
[filename, pathname] = uigetfile({'*.*'}, 'source',path);

if filename == 0
    im = 0;
    return;
end

im = imread([pathname, filename]);