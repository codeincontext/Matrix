/* Author: 

*/


var bitData = [
  [0,0,0,0,0,0,0,0],
  [0,1,0,0,0,0,0,0],
  [0,0,1,0,0,0,0,0],
  [0,0,0,1,0,0,0,0],
  [0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0],
];




function activateBit($bit) {
  $bit.addClass("active");
  bitData[$bit.data("i")][$bit.data("j")] = 1;
}

function deactivateBit($bit) {
  $bit.removeClass("active");
  bitData[$bit.data("i")][$bit.data("j")] = 0;
}

function bitGetByPosition(i,j, callback) {
  callback($("#id_"+i+"_"+j));
}

function processArray(array) {
  for (var i = 0; i < array.length; i++) {
    for (var j = 0; j<array[i].length; j++) {
      if (array[i][j] === 0) {
        bitGetByPosition(i,j, deactivateBit);   
      } else {
        bitGetByPosition(i,j, activateBit);   
      }
    }
  }
}

function submitData() {
  var options = {
    value:bitData
  };
  var url = "http://matrix.skatty.me/api";
  $.post(url, options, function(data) {});

}


$(document).ready(function() {

  for (var i = 0;i<8;i++) {
  
    var $byte = $("<div class='byte'/>");
    for (var j = 0;j<8;j++) {
      var $bit = $("<div class='bit' />");
      $bit.data("i", i).data("j", j).attr("id","id_"+i+"_"+j);
      
      $bit.click(function() {
        var $t = $(this);
        if ($t.hasClass("active")) {
          deactivateBit($t);
        } else {
          activateBit($t);
        }
        submitData();
      }) 
      
      $byte.append($bit);    
    }
    
    $("#interface").append($byte);
  }


  processArray(bitData);







  

})


















