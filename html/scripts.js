// Credit to Kanersps @ EssentialMode and Eraknelo @FiveM
function addGaps(nStr) {
  nStr += '';
  var x = nStr.split('.');
  var x1 = x[0];
  var x2 = x.length > 1 ? '.' + x[1] : '';
  var rgx = /(\d+)(\d{3})/;
  while (rgx.test(x1)) {
    x1 = x1.replace(rgx, '$1' + '<span style="margin-left: 3px; margin-right: 3px;"/>' + '$2');
  }
  return x1 + x2;
}
function addCommas(nStr) {
  nStr += '';
  var x = nStr.split('.');
  var x1 = x[0];
  var x2 = x.length > 1 ? '.' + x[1] : '';
  var rgx = /(\d+)(\d{3})/;
  while (rgx.test(x1)) {
    x1 = x1.replace(rgx, '$1' + ',<span style="margin-left: 0px; margin-right: 1px;"/>' + '$2');
  }
  return x1 + x2;
}

$(document).ready(function(){
  // Partial Functions
  function closeMain() {
    $(".home").css("display", "none");
  }
  function openMain() {
    $(".home").css("display", "block");
  }
  // Listen for NUI Events
  window.addEventListener('message', function(event){
    var item = event.data;
    // Open & Close main bank window
    if(item.openNUI == true) {
      openMain();
    }
    if(item.openNUI == false) {
      closeMain();
    }
  });
  // On 'Esc' call close method
  document.onkeyup = function (data) {
    if (data.which == 8 ) {
      $.post('http://vrp_giftbox/close', JSON.stringify({}));
    }
    if (data.which == 27 ) {
      $.post('http://vrp_giftbox/close', JSON.stringify({}));
    }
  };
  $("button").click(function(){
      $.post('http://vrp_giftbox/chance', JSON.stringify({}));
  });
});
