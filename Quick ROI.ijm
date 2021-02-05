//Version 1 Made by Tsai-Yi Lu 1.29.2021

imageTitle=getTitle();
newImageTitle=replace(imageTitle, ".tif", "");
directory=getInfo("image.directory");
selectWindow(imageTitle);
run("Z Project...", "projection=[Max Intensity]");
run("Select None");
run("Set Measurements...", "mean centroid redirect=None decimal=3");

//setTool("point");
run("Point Tool...", "type=Hybrid color=Yellow size=Small auto-measure add label show");
waitForUser("Please select the center of the neurons and click OK when done");

n = roiManager("count");
a1 = newArray(n+1);
for(i=0; i<n; i++){
	x = getResult("X", i);
	y = getResult("Y", i);
	makeOval(x-2, y-2, 5, 5);
	roiManager("add");
	a1[i] = i;
}

roiManager("select", a1);
roiManager("delete");
run("Select None");
run("Select All");
Roi.setName("Background");
roiManager("add");
a1[n] = n;
roiManager("select", a1);
roiManager("save", directory+newImageTitle+"_RoiSet.zip");

selectWindow("Results"); 
run("Close");

run("Set Measurements...", "mean redirect=None decimal=3");
selectWindow(imageTitle);
roiManager("select", a1);
roiManager("Multi Measure");
selectWindow("Results");
saveAs("Measurements", directory+newImageTitle+"_Results.csv");
selectWindow("Results"); 
run("Close");
selectWindow("ROI Manager");
run("Close");
run("Close All");
