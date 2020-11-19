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
            opacity: 0.6,
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

function alertSuccess(msg) {
    iziToast.success({
        title: 'Success',
        icon: 'fa fa-check-circle',
        message: msg,
        timeout: 10000,
        position: 'topRight',
    });
}

function alertWarning(msg) {
    iziToast.warning({
        title: 'Warning',
        message: msg,
        timeout: 10000,
        position: 'topRight',
    });
}

function alertError(msg) {
    iziToast.error({
        title: 'Error',
        message: msg,
        timeout: 10000,
        position: 'topRight',
    });
}

function loadInputToImage(input, target) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        var file = input.files[0];
        console.log(input.files[0]);
        reader.onload = function (e) {
            target.attr("src", e.target.result)
        }
        reader.readAsDataURL(input.files[0]); // convert to base64 string
    }
}

function imgsizevalidation(max, form) {
    const size = (form.files[0].size / 1024 / 1024).toFixed(2);
    if (size > max) {
        alertWarning("Ukuran image tidak boleh lebih dari "+max+" Mb");
       return false;
    }else{
       return true
    }
}

function deleteQuestion(callback, msg){
    iziToast.question({
        timeout: 20000,
        close: false,
        overlay: true,
        displayMode: 'once',
        id: 'question',
        zindex: 999,
        title: 'Hey',
        message: msg,
        position: 'center',
        buttons: [
            ['<button><b>YES</b></button>', function (instance, toast) {
                instance.hide({ transitionOut: 'fadeOut' }, toast, 'button');
                callback()
            }, true],
            ['<button>NO</button>', function (instance, toast) {
                instance.hide({ transitionOut: 'fadeOut' }, toast, 'button');
            }],
        ],
        onClosing: function(instance, toast, closedBy){
            console.info('Closing | closedBy: ' + closedBy);
        },
        onClosed: function(instance, toast, closedBy){
            console.info('Closed | closedBy: ' + closedBy);
        }
    });
}


function Question(callback, msg){
    iziToast.question({
        timeout: 100000,
        close: true,
        overlay: true,
        displayMode: 'once',
        id: 'question',
        zindex: 999,
        title: '',
        message: msg,
        position: 'center',
        buttons: [
            ['<button><b>YES</b></button>', function (instance, toast) {
                callback()
                instance.hide({ transitionOut: 'fadeOut' }, toast, 'button');
            }, true],
            ['<button>NO</button>', function (instance, toast) {
                instance.hide({ transitionOut: 'fadeOut' }, toast, 'button');
            }],
        ],
        onClosing: function(instance, toast, closedBy){
            console.info('Closing | closedBy: ' + closedBy);
        },
        onClosed: function(instance, toast, closedBy){
            console.info('Closed | closedBy: ' + closedBy);
        }
    });
}