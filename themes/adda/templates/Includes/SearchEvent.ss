<div class="card widget-item">
    <h4 class="widget-title">Search Event <i class="fa fa-search ml-2"></i></h4>
    <div class="widget-body">
        <div class="row">
            <form action="" method="GET">
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
                <div class="col-lg-12 d-flex">
                    <button type="submit" class="submit-btn mt-2 mr-1 text-center">Search</button>
                    <a href="{$BaseHref}event" class="submit-btn mt-2 bg-dark ml-1 text-center">Reset</a>
                </div>
            </form>
        </div>
    </div>
</div>
