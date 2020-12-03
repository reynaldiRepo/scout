    <%-- //modal for report --%>
    <div class="modal fade" id="report-modal" aria-labelledby="report-modal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Report</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <form method="POST" action="{$BaseHref}api-helper/doreport" id="doreport">
                    <div class="modal-body">
                        <fieldset class="form-group">
                            <div class="row">
                                <div class="alert alert-info">
                                    Silahkan lakukan report pada postingan ini bila dirasa telah melanggar kebijakan dalam menggunakan
                                    sistem ini, admin akan segera meninjau.
                                </div>
                                <input type="text" readonly class="form-control sr-only" name="ReportReasonDataID" id="target-report">
                                <div class="col-md-12">
                                    <% loop $getReasonReport %>
                                    <div class="c-pointer col-md-12 alert border m-0 mt-2 p-3 report-opt" id="report-$ID" data-id="$ID">
                                        $Title
                                    </div>
                                    <% end_loop %>
                                    <div class="c-pointer col-md-12 alert border m-0 mt-2 p-3 report-opt" id="report-0" data-id="0">
                                        Lainnya
                                    </div>
                                </div>
                            </div>
                            <div class="row" id="OtherReason">
                                <legend class="col-form-label col-sm-4 pt-0">Alasan Lainnya ? </legend>
                                <div class="col-sm-12">
                                    <textarea name="OtherReason" class="form-control" id="OtherReasonInput"></textarea>
                                </div>
                            </div>
                        </fieldset>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="post-share-btn" data-dismiss="modal">cancel</button>
                        <button type="submit" class="post-share-btn">post</button>
                    </div>
                </form>

            </div>
        </div>
    </div>
    <script>

        $(".report-opt").hover(function(){
            $(this).addClass("border-warning")
        }, function(){
            $(this).removeClass("border-warning")
        })

        $(".report-opt").click(function(){
            $(".report-opt").removeClass("alert-warning")
            $(this).addClass("alert-warning");
            $("#target-report").val($(this).attr("data-id"))
            if ($(this).attr("data-id") == "0"){
                $("#OtherReason").show();
            }else{
                $("#OtherReasonInput").val("");
                $("#OtherReason").hide();
            }
        })

        $('#report-modal').on('hidden.bs.modal', function () {
            $(".report-opt").removeClass("alert-warning")
            $("#target-report").val("")
            $("#OtherReasonInput").val("");
            $("#OtherReason").hide();
        })

        function doreport(e) {
            var id = $(e).attr("data-id");
            $("#doreport").attr("action", "{$BaseHref}api-helper/doreport?id="+id);
            $("#OtherReason").hide();
            $('#report-modal').modal('show');
        }

        $("#doreport").submit(function(e){
            e.preventDefault();
            var formData = new FormData(this)
            $.ajax({
                url: $(this).attr('action'),
                method: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                beforeSend: function () {
                    blockUI();
                }
            }).done(function (data) {
                $.unblockUI();
                console.log(data);
                data = JSON.parse(data)
                if (data.status == 200) {
                    alertSuccess(data.msg);
                    $('#report-modal').modal('hide');
                } else {
                    alertWarning(data.msg);
                }
            }).fail(function () {
                alertError("ERROR");
            })
        })

    </script>
