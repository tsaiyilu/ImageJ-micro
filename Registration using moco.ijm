imageTitle=getTitle();
getDimensions(w,h,channels,slices,frames);
directory=getInfo("image.directory");
run("Split Channels");
selectWindow("C2-"+imageTitle);
run("Close");
selectWindow("C1-"+imageTitle);
imageTitle=replace(imageTitle, ".czi", "");
run("Z Project...", "projection=[Sum Slices]");
Sum=getTitle();
selectWindow(Sum);
setOption("ScaleConversions", true);
run("8-bit");
run("moco ")
//, "value=102 downsample_value=1 template=[selectImage(+Sum)] stack=[selectImage(+imageTitle)] log=None plot=[No plot]");
saveAs("Tiff", directory+imageTitle+" moco.tif");
run("Close All");