<div class="col-lg-12 order-1 order-lg-2">
    <div class="card widget-item">
        <h3 class="widget-title mt-3 mb-4">$Title
            <button class="delete-btn search" data-toggle="modal" data-target="#modal-search">
                <span aria-hidden="true"><i class="fa fa-search"></i> Search</span>
            </button>    
        </h3>
        <div class="row">
        <% loop $Members %>
        <div class="col-lg-3 order-1 order-lg-2 mt-4 p-2">
            <% include GeneralProfileCard %>
        </div>
        <% end_loop %>
        </div>
    </div>
    <div class="col-lg-12 text-center">
        <div>
            <% if $Members.MoreThanOnePage %>
            <% if $Members.NotFirstPage %>
            <a class="prev btn-page p-1 pl-3 pr-3 bg-white btn" href="$Members.PrevLink"><i
                    class="fa fa-caret-left"></i><i class="fa fa-caret-left"></i></a>
            <% end_if %>
            <% loop $Members.PaginationSummary %>
            <% if $CurrentBool %>
            <a class="btn-page p-1 pl-3 pr-3 bg-theme text-white btn">$PageNum</a>
            <% else %>
            <% if $Link %>
            <a href="$Link" class="btn-page p-1 pl-3 pr-3 bg-white btn">$PageNum</a>
            <% else %>
            ...
            <% end_if %>
            <% end_if %>
            <% end_loop %>
            <% if $Members.NotLastPage %>
            <a class="next btn-page p-1 pl-3 pr-3 bg-white btn" href="$Members.NextLink"><i
                    class="fa fa-caret-right"></i><i class="fa fa-caret-right"></i></a>
            <% end_if %>
            <% end_if %>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="modal-search" tabindex="-1" role="dialog" aria-labelledby="modal-searchLabel"
    aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-theme">
                <h5 class="modal-title text-white" id="modal-searchLabel">Search Member</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form class="form-group" id="form-search" action="" method="GET">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12 p-2 pl-3 pr-3">
                            <label>Nama</label>
                            <input type="text" class="form-control" placeholder="Nama" name="Nama"
                            value="$Nama"/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 p-2 pl-3 pr-3">
                            <label>Saka</label>
                            <select class="slim-select" name="SakaDataID">
                                <option value = "">Pilih Saka</option>
                                <% loop getSaka %>
                                    <option value="$ID" 
                                        <% if $Up.SakaDataID == $ID %>
                                            selected
                                        <% end_if %>
                                        >
                                        <i class="$IconCode"></i> $Title
                                    </option>
                                <% end_loop %>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 p-2 pl-3 pr-3">
                            <label>Golongan</label>
                            <select class="slim-select" name="GolonganDataID">
                                <option value = "">Pilih Golongan</option>
                                <% loop getGolongan %>
                                    <option value="$ID" 
                                        <% if $Up.GolonganDataID == $ID %>
                                            selected
                                        <% end_if %>
                                        >
                                        <i class="$IconCode"></i> $Title
                                    </option>
                                <% end_loop %>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 p-2 pl-3 pr-3">
                            <label>Kwarcab</label>
                            <select class="slim-select" name="KwarcabID">
                                <option value = "">Pilih Kwarcab</option>
                                <% loop getKabupatenJatim %>
                                    <option value="$ID" 
                                        <% if $Up.KwarcabID == $ID %>
                                            selected
                                        <% end_if %>
                                        >
                                        <i class="$IconCode"></i> $Title
                                    </option>
                                <% end_loop %>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="submit-btn">Search <i class="fa fa-search"></i></button>
                    <a href="{$BaseHref}member/all" class="submit-btn bg-dark text-center">Reset</a>
                </div>
            </form>
        </div>
    </div>
</div>
