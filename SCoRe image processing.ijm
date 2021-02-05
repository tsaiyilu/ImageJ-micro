imageTitle=getTitle();
directory=getInfo("image.directory");
selectWindow(imageTitle);
getDimensions(w,h,channels,slices,frames);
run("Subtract Background...", "rolling=30 sliding stack");
run("Split Channels");
imageCalculator("Add create 32-bit stack", "C1-"+imageTitle,"C2-"+imageTitle);
imageCalculator("Add create 32-bit stack", "Result of C1-"+imageTitle,"C3-"+imageTitle);
close("C1-"+imageTitle);
close("C2-"+imageTitle);
close("C3-"+imageTitle);
close("Result of C1-"+imageTitle)
imageTitle=replace(imageTitle, ".czi", "");
saveAs("Tiff", directory+imageTitle+"_result.tif");

