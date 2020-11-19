<div class="col-lg-3 order-2 order-lg-1 search-event-side">
    <% if $CurrentMember %>
    <% include SearchEvent %>
    <% end_if %>
</div>
<div class="col-lg-9 order-1 order-lg-2">
    <div class="card widget-item">
        <h3 class="widget-title mt-3 mb-4">$Title
            <button class="delete-btn search-event" data-toggle="modal" data-target="#modal-search">
                <span aria-hidden="true"><i class="fa fa-search"></i> Search</span>
            </button>
        </h3>
        <div class="col-lg-12 mt-3 mb-2 mt-0 p-0">
            <div class="row">
                <% if Events %>
                <% loop Events %>
                <div class="col-sm-6 col-md-6 mb-2">
                    <div class="photo-group p-0 m-2">
                        <div class="gallery-toggle">
                            <div class="d-none product-thumb-large-view">
                                <img src="$getImageEvent.URL" alt="Photo Gallery">
                            </div>
                            <div class="gallery-overlay">
                                <img src="$getImageEvent.Fill(380,270).URL" alt="Photo Gallery">
                                <div class="view-icon"></div>
                            </div>
                        </div>
                        <div class="photo-gallery-caption">
                            <div class="list-group">
                                <a href="$Link" class="list-group-item list-group-item-action text-center"
                                    style="text-transform:uppercase">
                                    <b>$Title</b>
                                </a>
                                <% if $Mulai %>
                                <a href="$Link" class="list-group-item list-group-item-action text-left">
                                    <i class="fa-theme fa fa-calendar mr-2"></i> $Mulai.Format('dd-MM-YYYY')
                                    <i class="fa-theme fa fa-clock-o ml-2 mr-2"></i> $Mulai.Format('hh : mm')</a>
                                <% end_if %>
                                <% if $SakaData %>
                                <a href="$Link" class="list-group-item list-group-item-action text-left"><i
                                        class="fa-theme fa fa-building mr-2"></i> $SakaData.Title</a>
                                <% end_if %>
                                <% if $KategoriEventData %>
                                <a href="$Link" class="list-group-item list-group-item-action text-left"><i
                                        class="fa-theme fa fa-folder mr-2"></i> $KategoriEventData.Title</a>
                                <% end_if %>
                                <% if $Content %>
                                <a href="$Link" class="list-group-item list-group-item-action text-left">
                                    $Content.LimitCharacters(50,'...read more...')
                                </a>
                                <% end_if %>
                            </div>
                        </div>
                    </div>
                </div>
                <% end_loop %>
                <% else %>
                <p class="alert"> No Data </p>
                <% end_if %>
                <div class="col-lg-12 text-center mt-3 mb-2">
                    <div>
                        <% if $Events.MoreThanOnePage %>
                        <% if $Events.NotFirstPage %>
                        <a class="prev btn-page p-1 pl-3 pr-3 bg-white btn" href="$Events.PrevLink"><i
                                class="fa fa-caret-left"></i><i class="fa fa-caret-left"></i></a>
                        <% end_if %>
                        <% loop $Events.PaginationSummary %>
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
                        <% if $Events.NotLastPage %>
                        <a class="next btn-page p-1 pl-3 pr-3 bg-white btn" href="$Events.NextLink"><i
                                class="fa fa-caret-right"></i><i class="fa fa-caret-right"></i></a>
                        <% end_if %>
                        <% end_if %>
                    </div>
                </div>
            </div>
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
                    <div class="col-lg-12">
                        <div class="form-group">
                            <label>
                                Nama Event
                            </label>
                            <input type="text" class="form-control" name="Title" value="$TitleSearch"
                                placeholder="Nama Event">
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <div class="form-group">
                            <label>
                                Saka
                            </label>
                            <select class="slim-select" name="SakaDataID">
                                <option value="">Pilih Saka</option>
                                <% loop getSaka %>
                                <option value="$ID" <% if $Up.SakaDataID == $ID %> selected <% end_if %>>
                                    $Title
                                </option>
                                <% end_loop %>
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <div class="form-group">
                            <label>
                                Kategori Event
                            </label>
                            <select class="slim-select" name="KategoriEventDataID">
                                <option value="">Pilih Kategori Event</option>
                                <% loop getKategoriEventData %>
                                <option value="$ID" <% if $Up.KategoriEventDataID == $ID %> selected <% end_if %>>
                                    $Title
                                </option>
                                <% end_loop %>
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <div class="form-group">
                            <label>
                                <i class="fa fa-sort"></i> Sort
                            </label>
                            <select class="slim-select" name="Sort">
                                <% loop arrSoort %>
                                <option value="$q" <% if $Up.Sort == $q %> selected <% end_if %>>
                                    $Title
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
