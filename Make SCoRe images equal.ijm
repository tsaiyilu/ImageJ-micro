//
directory = getDirectory("Choose input directory");
fileList = getFileList(directory);
outputDirectory = getDirectory("Choose output directory");

run("Bio-Formats Macro Extensions");

maxSlice = 0;

for (i=0; i<fileList.length; i++) {
	file = directory + fileList[i];
	Ext.setId(file);
	print(file);
	Ext.getSizeZ(newSlice);

	//Save the largest number of slices within the dataset
	if (newSlice>maxSlice) {
		maxSlice = newSlice;
		print(maxSlice);
	}
}

for (i=0; i<fileList.length; i++) {
	file = directory + fileList[i];
	Ext.setId(file);
	Ext.getSizeX(width);
	Ext.getSizeY(height);
	Ext.getSizeZ(sliceN);

	extras = maxSlice - sliceN;
	print(maxSlice);
	print(sliceN);
	print(extras);

	if (extras == 0) {
		open(file);
		imgTitle = getTitle();
		print("No extra slides are needed for"+file);
		imgTitle=replace(imgTitle, ".tif", "");
		saveAs("Tiff", outputDirectory+imgTitle+"_extras.tif");
		run("Close All");
	}
	else {
		open(file);
		imgTitle = getTitle();
		newImage("blank_slices", "32-bit black", width, height, extras);
		run("Concatenate...", "image1 ="+imgTitle+" image2 =blank_slices");
		print("An extra of "+extras+" slices are added to "+file);
		imgTitle=replace(imgTitle, ".tif", "");
		saveAs("Tiff", outputDirectory+imgTitle+"_extras.tif");
		run("Close All");
	}	
}






