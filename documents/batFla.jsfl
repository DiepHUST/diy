function Main()
{
	getFLA(folderURI);
	if(flaList.length<1)
	{
		alert("该目录没有FLA文件可编译");
		return;
	}
	var doc;
	var temp_uri;
	var pub_uri;
	var file_name;
	for(var i=0;i<flaList.length;i++)
	{
		doc=fl.openDocument(flaList[i]);
		fl.outputPanel.clear();
		doc.publish();
		doc.close();
		var temp_str=flaList[i];
		temp_uri=temp_str.slice(folderURI.length+1,temp_str.lastIndexOf("/"));
		file_name=temp_str.slice(temp_str.lastIndexOf("/")+1,temp_str.indexOf(".fla"));
		file_name+=".swf";
		pub_uri=saveURI+"/"+temp_uri;
		if(!FLfile.exists(pub_uri))
		{
			FLfile.createFolder(pub_uri);
		}
		pub_uri+="/"+file_name
		temp_uri=temp_str.slice(0,temp_str.indexOf(".fla"));
		temp_uri+=".swf";
		FLfile.copy(temp_uri,pub_uri);
	}
}
function getFLA(uri)
{
	var fla=FLfile.listFolder(uri+"/"+"*.fla","files");
	var dir=FLfile.listFolder(uri,"directories");
	for(var i=0;i<fla.length;i++)
	{
		flaList.push(uri+"/"+fla[i]);
	}
	if(dir!=null)
	{
		for(var i=0;i<dir.length;i++)
		{
			var temp_uri=uri+"/"+dir[i];
			getFLA(temp_uri);
		}
	}
}