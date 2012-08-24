
var quicklook = require('bencoding.quicklook');
Ti.API.info("module is => " + quicklook);

//Setup our directory tests
var testDir = Ti.Filesystem.getFile(Ti.Filesystem.applicationDataDirectory,'foo');
//Make our test directory if it doesn't exist
if(!testDir.exists()){
	testDir.createDirectory();
}

var testFile = Ti.Filesystem.getFile(testDir.nativePath,"test2.pdf");
//If it doesn't exist in that directory we copy it from our app
if(!testFile.exists()){
	var cannedTest = Ti.Filesystem.getFile(Ti.Filesystem.resourcesDirectory,"test2.pdf");
	 testFile.write(cannedTest.read());
}
			
// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'blue'
});

var _index = 0;
var foo = quicklook.createView({
			top:10,bottom:40,left:20,right:20,
			documents:["test.pdf","/TestDir/Remodel.xls",testFile.nativePath]
		});
win.add(foo);

var b1 = Titanium.UI.createButton({
	title:'Go to back', height:40, width:100, bottom:10, left:5
});
win.add(b1);

b1.addEventListener('click',function(e){
	_index--;
	foo.index=_index;
});

var b2 = Titanium.UI.createButton({
	title:'Go to next', height:40, width:100, bottom:10, right:5
});
win.add(b2);

b2.addEventListener('click',function(e){
	_index++;
	foo.index=_index;
});

win.open();
