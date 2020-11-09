$showPanel(Plastyk\Dashboard\Panels\UpdatePanel)
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.css"
    integrity="sha512-C7hOmCgGzihKXzyPU/z4nv97W0d9bv4ALuuEbSf6hm93myico9qa0hv4dODThvCsqQUmKmLcJmlpRmCaApr83g=="
    crossorigin="anonymous" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"
    integrity="sha512-hZf9Qhp3rlDJBvAKvmiG+goaaKRZA6LKUO35oK6EsM0/kjPK32Yw7URqrq3Q+Nvbbt8Usss+IekL7CRn83dYmw=="
    crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@0.7.0"></script>


    <div class="cms-content-header north" style="margin-top:-15px; margin-bottom:30px">
		<div class="cms-content-header-info vertical-align-items flexbox-area-grow">
			<div class="breadcrumbs-wrapper">
				<span class="cms-panel-link crumb last">
                    Dashboard
				</span>
			</div>
		</div>
	</div>


<div class="container-fluid">
    <div class="row">
        <div class="col-lg-12">
            <div class="dashboard-panel">
                <h2 style="margin-bottom:0; text-transform:uppercase">$SiteConfig.Title</h2>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-6">
            <div class="dashboard-panel">
                <h2>Jumlah Member Berdasarkan Golongan</h2>
                <div>
                    <canvas id="baseGolonganChart"></canvas>
                    <hr>
                    <a href="admin/Member" class="btn btn-info text-white">Lihat Lainnya</a>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="dashboard-panel">
                <h2>Jumlah Member Berdasarkan Saka</h2>
                <div>
                    <canvas id="baseSakaChart"></canvas>
                    <hr>
                    <a href="admin/Member" class="btn btn-info text-white">Lihat Lainnya</a>
                </div>
            </div>
        </div>
        <div class="col-lg-12">
            <div class="dashboard-panel">
                <h2>Jumlah Member Berdasarkan Lokasi</h2>
                <div>
                    <canvas id="baseLocChart"></canvas>
                    <hr>
                    <a href="admin/Member" class="btn btn-info text-white">Lihat Lainnya</a>
                </div>
            </div>
        </div>
    </div>
</div>


<script>

    var optBar = {
            legend : {
                display: false
            },
            scales: {
                xAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }]
            },
            plugins: {
                datalabels: {
                    align: 'start',
                    anchor: 'end',
                    color: function(context) {
                        return "#FFF";
                    },
                    font: function(context) {
                        var w = context.chart.width;
                        return {
                            size: w < 512 ? 12 : 14
                        };
                    },
                }
            },
        }

    var ctx = document.getElementById('baseLocChart').getContext('2d');
    var baseLocChart = new Chart(ctx, {
        type: 'horizontalBar',
        data: {
            labels: [
                <% loop $getNumMemberByPlace %>
                        '$Title',
                <% end_loop %>
            ],
            datasets: [{
				data: [
                    <% loop $getNumMemberByPlace %>
                        '$Jumlah',
                    <% end_loop %>
                ],
                backgroundColor: [
                    <% loop $getNumMemberByPlace %>
                        '$Color',
                    <% end_loop %>
                ],
            }]
        },
        options : optBar
        
    });


    var ctx = document.getElementById('baseSakaChart').getContext('2d');
    var baseSakaChart = new Chart(ctx, {
        type: 'horizontalBar',
        data: {
            labels: [
                <% loop $getNumMemberBySaka %>
                        '$Title.LimitWordCount(2,'...')',
                <% end_loop %>
            ],
            datasets: [{
				data: [
                    <% loop $getNumMemberBySaka %>
                        '$Jumlah',
                    <% end_loop %>
                ],
                backgroundColor: [
                    <% loop $getNumMemberBySaka %>
                        '$Color',
                    <% end_loop %>
                ],
            }]
        },
        options: optBar
    });


    var ctx = document.getElementById('baseGolonganChart').getContext('2d');
    var baseSakaChart = new Chart(ctx, {
        type: 'horizontalBar',
        data: {
            labels: [
                <% loop $getNumMemberByGolongan %>
                        '$Title.LimitWordCount(2,'...')',
                <% end_loop %>
            ],
            datasets: [{
				data: [
                    <% loop $getNumMemberByGolongan %>
                        '$Jumlah',
                    <% end_loop %>
                ],
                backgroundColor: [
                    <% loop $getNumMemberByGolongan %>
                        '$Color',
                    <% end_loop %>
                ],
            }]
        },
        options: optBar
    });

</script>
