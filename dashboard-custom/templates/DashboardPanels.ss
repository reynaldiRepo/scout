<%-- $showPanel(Plastyk\Dashboard\Panels\UpdatePanel) --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.css"
    integrity="sha512-C7hOmCgGzihKXzyPU/z4nv97W0d9bv4ALuuEbSf6hm93myico9qa0hv4dODThvCsqQUmKmLcJmlpRmCaApr83g=="
    crossorigin="anonymous" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"
    integrity="sha512-hZf9Qhp3rlDJBvAKvmiG+goaaKRZA6LKUO35oK6EsM0/kjPK32Yw7URqrq3Q+Nvbbt8Usss+IekL7CRn83dYmw=="
    crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@0.7.0"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqvmap/1.5.1/jqvmap.min.css" integrity="sha512-RPxGl20NcAUAq1+Tfj8VjurpvkZaep2DeCgOfQ6afXSEgcvrLE6XxDG2aacvwjdyheM/bkwaLVc7kk82+mafkQ==" crossorigin="anonymous" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqvmap/1.5.1/jquery.vmap.min.js" integrity="sha512-Zk7h8Wpn6b9LpplWXq1qXpnzJl8gHPfZFf8+aR4aO/4bcOD5+/Si4iNu9qE38/t/j1qFKJ08KWX34d2xmG0jrA==" crossorigin="anonymous"></script>
<script src="{$BaseHref}public/_resources/JS/vmap.jatim.js" crossorigin="anonymous"></script>

<div class="cms-content-header north" style="margin-top: -15px;
    margin-bottom: 30px;
    position: sticky;
    top: 0;">
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
    <div class="row pl-3 pr-3"> 
        <div class="col-md-3 p-1">
            <a href="{$BaseHref}admin/Member">
                <div class="dashboard-panel bg-info text-white">
                        <h2 style="margin-bottom:0; text-transform:uppercase">Member</h2>
                        <div class="d-block">
                            <b style="font-size:48px">$getNMember</b>
                            <i class="fa fa-users mt-1 float-right" style="font-size:48px"></i>
                        </div>
                </div>
            </a>
        </div>
        <div class="col-md-3 p-1">
            <a href="{$BaseHref}admin/Event">
                <div class="dashboard-panel bg-warning text-white">
                        <h2 style="margin-bottom:0; text-transform:uppercase">Event</h2>
                        <div class="d-block">
                            <b style="font-size:48px">$getNEvent</b>
                            <i class="fa fa-calendar-alt mt-1 float-right" style="font-size:48px"></i>
                        </div>
                </div>
            </a>
        </div>
        <div class="col-md-3 p-1">
            <a href="{$BaseHref}admin/admindata">
                <div class="dashboard-panel bg-danger text-white">
                        <h2 style="margin-bottom:0; text-transform:uppercase">Admin Cabang</h2>
                        <div class="d-block">
                            <b style="font-size:48px">$getAdminCabang</b>
                            <i class="fa fa-user-shield mt-1 float-right" style="font-size:48px"></i>
                        </div>
                </div>
            </a>
        </div>
        <div class="col-md-3 p-1">
            <div class="dashboard-panel bg-white">
                    <h2 style="margin-bottom:0; text-transform:uppercase; opacity:0">Admin Cabang</h2>
                    <div class="d-block" style="opacity:0">
                        <b style="font-size:48px">$getAdminCabang</b>
                        <i class="fa fa-user-shield mt-1 float-right" style="font-size:48px"></i>
                    </div>
                <div class="overlay"></div>
                <iframe style="position: absolute;top: 1.4rem;left: 0px;" src="https://www.zeitverschiebung.net/clock-widget-iframe-v2?language=en&size=small&timezone=Asia%2FJakarta" width="100%" height="93" frameborder="0" seamless></iframe>
            </div>
        </div>
        
    </div>
    <div class="row">
        <div class="col-lg-6">
            <div class="dashboard-panel">
                <h2>Selamat Datang $CurrentMember.FirstName $CurrentMember.Surname</h2>
                <div class="col-lg-12">
                    <img src="{$BaseHref}public/_resources/images/custom-1.svg" class="img-fluid"></img>
                    <hr>
                    <b class="text mt-3 text-center">$getMsgAdmin</b>
                    <hr>
                </div>
                <div class="col-lg-12 mb-3">
                    <div>
                        <i class="ml-auto mt-2">Today is good day : $getDate</i>
                        <a href="$SiteConfig.PanduanAdmin.URL" target="_blank" class="float-right btn btn-info text-white"><i class="fa fa-download mr-2"></i>Download Panduan Admin</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="dashboard-panel pb-4">
                <h2>Jumlah Member Berdasarkan Golongan</h2>
                <div>
                    <canvas id="baseGolonganChart"></canvas>
                    <canvas id="baseGolonganPieChart"></canvas>
                    <hr>
                    <a href="admin/Member" class="btn btn-info text-white">Lihat Lainnya</a>
                    <div class="form-check float-right">
                        <input type="checkbox" class="form-check-input" id="golongan-pie">
                        <label class="form-check-label" for="golongan-pie">Show Pie Chart</label>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="dashboard-panel">
                <h2>Jumlah Member Berdasarkan Saka</h2>
                <div>
                    <canvas id="baseSakaChart"></canvas>
                    <canvas id="baseSakaPieChart"></canvas>
                    <hr>
                    <a href="admin/Member" class="btn btn-info text-white">Lihat Lainnya</a>
                    <div class="form-check float-right">
                        <input type="checkbox" class="form-check-input" id="saka-pie">
                        <label class="form-check-label" for="saka-pie">Show Pie Chart</label>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="dashboard-panel">
                <h2>Jumlah Member Berdasarkan Lokasi</h2>
                <div>
                    <hr>
                    <div style="height:295px" id="baseLocChart"></div>
                    <hr>
                    <a href="admin/Member" class="btn btn-info text-white">Lihat Lainnya</a>
                </div>
            </div>
        </div>
        <div class="col-lg-12">
            <div class="dashboard-panel">
                <h2>Detail Jumlah Member Berdasarkan Lokasi</h2>
                <div class="mt-2 mb-2">
                    <a target="_blank" href="{$BaseHref}admin/dashboard/exportmemberbysakakwarcab"
                     class="btn btn-info text-white"><i class="fa fa-upload mr-2"></i>Export to CSV</a>
                </div>
                <div style="height:400px; overflow-y:scroll">
                    <hr>
                    <div>
                        <table class="table table-bordered table-striped" id="table-detail">
                            <tr>
                                <th>
                                    Kabupaten / Kota
                                </th>
                                <% loop $getSakaList %>
                                    <th>
                                        $getTitleShort
                                    </th>
                                <% end_loop %>
                            </tr>
                            <% loop $getKabJatim %>
                                <tr>
                                    <td>$getTitleShort</td>
                                    <% loop $Up.countMemberBySakaKwarcab($ID) %>
                                        <td>
                                            $jumlah
                                        </td>
                                    <% end_loop %>
                                </tr>
                            <% end_loop %>
                        </table>
                    </div>
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

    var optpie = {
        legend : {
            display: jQuery(window).width() < 785 ? false : true,
            position: 'left'
        },
        plugins: {
            datalabels: {
                align: 'start',
                anchor: 'end',
                formatter: (value, ctx) => {
                    let sum = 0;
                    let dataArr = ctx.chart.data.datasets[0].data;
                    console.log(dataArr)
                    dataArr.map(data => {
                        sum += parseFloat(data);
                    });
                    console.log(sum)
                    let percentage = (value / sum * 100).toFixed(2)+"%";
                    return percentage;
                },
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


    var ctx = document.getElementById('baseSakaPieChart').getContext('2d');
    var baseSakaPieChart = new Chart(ctx, {
        type: 'pie',
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
        options:  optpie
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


    var ctx = document.getElementById('baseGolonganPieChart').getContext('2d');
    var baseSakaPieChart = new Chart(ctx, {
        type: 'pie',
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
        options: optpie
    });
</script>

<script>
var sakaChart = jQuery("#baseSakaChart")
var sakaPieChart = jQuery("#baseSakaPieChart")
var GolonganChart = jQuery("#baseGolonganChart")
var GolonganPieChart = jQuery("#baseGolonganPieChart")
var sakacb = jQuery("#saka-pie")
var golongancb = jQuery("#golongan-pie")

sakaPieChart.hide()
GolonganPieChart.hide()

sakacb.change(function(){
    if (jQuery(this).is(":checked")){
        sakaChart.hide()
        sakaPieChart.show()
    }else{
        sakaChart.show()
        sakaPieChart.hide()
    }
})

golongancb.change(function(){
    if (jQuery(this).is(":checked")){
        GolonganChart.hide()
        GolonganPieChart.show()
    }else{
        GolonganChart.show()
        GolonganPieChart.hide()
    }
})

</script>


<script>

    function getRandomColor() {
        var letters = '0123456789ABCDEF';
        var color = '#';
        for (var i = 0; i < 6; i++) {
            color += letters[Math.floor(Math.random() * 16)];
        }
        return color;
    }
    
    var gdpData = {};
    <% loop $getNumMemberByKab %>
        gdpData['$path'] = $jumlah 
    <% end_loop %>

    //find maximum and minimum values
    colors = {};
    <% loop $getNumMemberByKab %>
        colors['$path'] = '$color' 
    <% end_loop %>
    
    
    console.log(colors)
      jQuery(document).ready(function () {
        jQuery('#baseLocChart').vectorMap({
          map: 'jatim',
		  colors: colors,
          showTooltip: true,
          selectedColor: null,
          focusOn: {
            x: 0.5,
            y: 0.5,
            scale: 2,
            animate: true
          },
		  onLabelShow: function (event, label, code) {
				label.append(': '+gdpData[code]+' Peserta'); 
		  }
        });
      });
    
</script>