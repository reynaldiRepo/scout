(function ($) {
    var baseHref = '';
    if (window.location.href.includes('localhost')){
        baseHref = 'http://localhost/pramuka/'
    }else{
        baseHref = window.location.origin+"/"
    }

    function onChangeKabupaten(e, target) {
        if (e.val() != "") {
            $.ajax({
                url: baseHref + "api-helper/getkecamatan?idkab=" + e.val(),
                method: "GET",
            }).done(function (data) {
                data = JSON.parse(data);
                target.html("");
                data.forEach(element => {
                    target.append("<option value='" + element.ID + "'>" + element.Title + "</option>")
                });
                target.chosen("destroy");
                target.chosen({
                    disable_search_threshold: 10
                });
                target.trigger("chosen:updated")
            })
            return;
        } else {
            target.html("");
            target.append("<option value=''>Pilih kota anda terlebih dahulu</option>")
            target.chosen("destroy");
            target.chosen({
                disable_search_threshold: 10
            });
            target.trigger("chosen:updated")
            return;
        }
    }


    

    $(document).ready(function () {
        $(document).delegate('select#Form_ItemEditForm_KabupatenSelect', 'change', function () {
            var FormKecamatan = $("select#Form_ItemEditForm_KecamatanID");
            onChangeKabupaten($(this), FormKecamatan)
        })
        $(document).delegate('select#Form_ItemEditForm_KwarcabID', 'change', function () {
            var Form = $("select#Form_ItemEditForm_KwarranID");
            onChangeKabupaten($(this), Form)
        })
    });


})(jQuery);
