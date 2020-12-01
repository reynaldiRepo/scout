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
                                <legend class="col-form-label col-sm-4 pt-0">Report Dengan alsan</legend>
                                <div class="col-sm-8">
                                    <% loop $getReasonReport %>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="ReportReasonDataID" required
                                            id="ReportReasonDataID{$ID}" value="$ID">
                                        <label class="form-check-label" for="ReportReasonDataID{$ID}">
                                            $Title
                                        </label>
                                    </div>
                                    <% end_loop %>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="ReportReasonDataID" required
                                            id="ReportReasonDataID-other" value="0">
                                        <label class="form-check-label" for="ReportReasonDataID-other">
                                            Lainnya ..
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="row"  id="OtherReason">
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

        $('input[name="ReportReasonDataID"]').change(function () {
            if ($(this).val() == "0") {
                $("#OtherReason").show();
                $("#OtherReasonInput").prop('required',true);
                return;
            }
            $("#OtherReason").hide();
            $("#OtherReasonInput").prop('required',false);
        })

        $('#report-modal').on('hidden.bs.modal', function () {
            $('input[name="ReportReasonDataID"]').each(function(){
               $(this).prop("checked", false) 
            })
            $("#OtherReasonInput").val("")
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
