var fs = require('fs');
var nameList = [];
var path = require("path");

fs.readdir("src/scss/", function (err, files) {
    if (err) {
        throw err;
    }

    files.map(function (file) {
        return path.join("src/scss/", file);
    }).filter(function (file) {
        return fs.statSync(file).isFile();
    }).forEach(function (file) {
      if(path.extname(file) == ".scss" || path.extname(file) == ".css"){
        var _scssFile = file.split(".")[0];
        if(_scssFile.split("_")[1]){
          nameList.push("" + file.split("_")[1]);
        }else if (file.split("/scss/")[1] != "main.scss"){
          nameList.push("" + file.split("/scss/")[1]);
        }
      }
    });

    files.map(function (file) {
        return path.join("src/scss/", file);
    }).filter(function (file) {
        return fs.statSync(file).isDirectory();
    }).forEach(function (dir) {
      fs.readdir(dir + "", function (err, files) {
        for (_index in files){
          var file = files[_index];
          if(file.split(".")[1] == "scss"){
            nameList.push(dir.split("/scss/")[1] + "/" + file);
          }
        }
        writeName(nameList);
      });

    });
});

function writeName(_list){
  var _nameList = [];
  for(_index in _list){
    _nameList.push('@import "' + _list[_index] + '"')
  }
  var _str = _nameList.join(';\n');
  fs.writeFile('src/scss/main.scss', _str, function (err) {
  	if (err){
  		console.log(err);
  	}
   });
}
