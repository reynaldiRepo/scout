$.fn.center = function () {
  this.css("position", "absolute");
  this.css("top", ($(window).height() - this.height()) / 2 + $(window).scrollTop() + "px");
  this.css("left", ($(window).width() - this.width()) / 2 + $(window).scrollLeft() + "px");
  return this;
}

function blockUI() {
    $.blockUI({
      css: {
        backgroundColor: 'transparent',
        border: 'none'
      },
      message: '<div class="loading"></div>',
      baseZ: 1500,
      overlayCSS: {
        backgroundColor: '#FFFFFF',
        opacity: 1,
        cursor: 'wait'
      }
    });
    $('.blockUI.blockMsg').center();
  }
  //end Blockui 

  iziToast.settings({
    timeout: 10000,
    resetOnHover: true,
    transitionIn: 'flipInX',
    transitionOut: 'flipOutX',
    position: 'topRight'
  });
  
  function alertSuccess(msg){
    iziToast.success({
      title: 'Success',
      icon:'fa fa-check-circle',
      message: msg,
      timeout: 10000,
      position: 'topRight',
    });
  }

  function alertWarning(msg){
    iziToast.warning({
      title: 'Warning',
      message: msg,
      timeout: 10000,
      position: 'topRight',
    });
  }

  function alertError(msg){
    iziToast.error({
      title: 'Error',
      message: msg,
      timeout: 10000,
      position: 'topRight',
    });
  }