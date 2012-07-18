
// TODO: write your module tests here
var quicklook = require('bencoding.quicklook');
Ti.API.info("module is => " + quicklook);


// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'blue'
});

var _index = 0;
var foo = quicklook.createTestView({
			top:10,bottom:40,left:20,right:20,
			documents:["test.pdf","Remodel.xls"]
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


