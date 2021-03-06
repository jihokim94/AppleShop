<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/_side.jsp" %>
<style type="text/css">
.highcharts-figure, .highcharts-data-table table {
    min-width: 310px; 
    max-width: 800px;
    margin: 1em auto;
}

#container {
    height: 400px;
}

.highcharts-data-table table {
	font-family: Verdana, sans-serif;
	border-collapse: collapse;
	border: 1px solid #EBEBEB;
	margin: 10px auto;
	text-align: center;
	width: 100%;
	max-width: 500px;
}
.highcharts-data-table caption {
    padding: 1em 0;
    font-size: 1.2em;
    color: #555;
}
.highcharts-data-table th {
	font-weight: 600;
    padding: 0.5em;
}
.highcharts-data-table td, .highcharts-data-table th, .highcharts-data-table caption {
    padding: 0.5em;
}
.highcharts-data-table thead tr, .highcharts-data-table tr:nth-child(even) {
    background: #f8f8f8;
}
.highcharts-data-table tr:hover {
    background: #f1f7ff;
}

</style>

<style type="text/css">
.highcharts-figure, .highcharts-data-table table {
    min-width: 320px; 
    max-width: 660px;
    margin: 1em auto;
}

.highcharts-data-table table {
	font-family: Verdana, sans-serif;
	border-collapse: collapse;
	border: 1px solid #EBEBEB;
	margin: 10px auto;
	text-align: center;
	width: 100%;
	max-width: 500px;
}
.highcharts-data-table caption {
    padding: 1em 0;
    font-size: 1.2em;
    color: #555;
}
.highcharts-data-table th {
	font-weight: 600;
    padding: 0.5em;
}
.highcharts-data-table td, .highcharts-data-table th, .highcharts-data-table caption {
    padding: 0.5em;
}
.highcharts-data-table thead tr, .highcharts-data-table tr:nth-child(even) {
    background: #f8f8f8;
}
.highcharts-data-table tr:hover {
    background: #f1f7ff;
}
</style>

<script src="${pageContext.request.contextPath}/resources/chart/highcharts.js"></script>
<script src="${pageContext.request.contextPath}/resources/chart/modules/exporting.js"></script>
<script src="${pageContext.request.contextPath}/resources/chart/modules/export-data.js"></script>
<script src="${pageContext.request.contextPath}/resources/chart/modules/accessibility.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	var myChart = null; 
	var options = {
		    chart: {
		        type: 'column', // 'line' //'column' //'bar'
		        renderTo: 'stat_plot'
		    },
		    title: {
		        text: '????????? ??????'
		    },
		    subtitle: {
		        text: '???????????? ?????????'
		    },
		    xAxis: {
		    	title: {
		    		text: '?????????'
		    	},
		        categories: ['a', 'b'],	        
		        crosshair: true
		    },
		    yAxis: {
		        min: 0,
		        title: {
		            text: '(???)'
		        }
		    },
		    tooltip: {
		        headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
		        pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
		            '<td style="padding:0"><b>{point.y:.1f} ???</b></td></tr>',
		        footerFormat: '</table>',
		        shared: true,
		        useHTML: true
		    },
		    plotOptions: {
		        column: {
		            pointPadding: 0.2,
		            borderWidth: 0,
		            dataLabels: {
		            	enabled: true
		            },
		            enableMouseTracking: true
		        }
		    },
		    credits: false,
		    series: [
		    	{
		        	name: '?????????',
					color: '#FF0000'
		    	}
		    ]
		};	
	
	
	$("#asStatperArticle").on("click", function() {
		var CTX = '${pageContext.request.contextPath}';
		var url = CTX + "/stat_rv_count.ap";
		myChart = new Highcharts.chart(options);

		$.ajax({
			type: 'post',
			data: 'dummy=123',
			url: url,
			dataType: 'json',
			success: function(res, status, xhr) {
				console.log(res);
				myChart.xAxis[0].setCategories(res.rvTitleData, true);
				myChart.series[0].setData(res.readCntData, true);
				/* myChart.series[1].setData(res.cpSumData, true);
				myChart.series[2].setData(res.cpAvgData, true); */
			}, 
			error: function(xhr,status) { // ????????? ????????? ???????????? ???????????? ??? 3xx,4xx,5xx
				console.log("ERROR: " + status);  // error
				console.log("ERROR: " + xhr.status); // 400
			},
		});
		//
	});
	
	// Radialize the colors - pie ???????????????
	Highcharts.setOptions({
	    colors: Highcharts.map(Highcharts.getOptions().colors, function (color) {
	        return {
	            radialGradient: {
	                cx: 0.5,
	                cy: 0.3,
	                r: 0.7
	            },
	            stops: [
	                [0, color],
	                [1, Highcharts.color(color).brighten(-0.3).get('rgb')] // darken
	            ]
	        };
	    })
	});
	
	var options2 = {
		    chart: {
		        plotBackgroundColor: null,
		        plotBorderWidth: null,
		        plotShadow: true,
		        type: 'pie',
		        renderTo: 'stat_plot2'
		    },
		    title: {
		        text: '?????? ??? ????????? ?????? ?????? (%)'
		    },
		    tooltip: {
		        pointFormat: '????????? ?????? {series.name}: <b>{point.percentage:.1f}%</b>'
		    },
		    accessibility: {
		        point: {
		            valueSuffix: '%'
		        }
		    },
		    credits: false,
		    plotOptions: {
		        pie: {
		            allowPointSelect: true,
		            cursor: 'pointer',
		            dataLabels: {
		                enabled: true,
		                format: '<b>{point.name}</b>: {point.percentage:.1f} %',
		                connectorColor: 'silver'
		            }
		        }
		    },
		    series: [{
		        name: '',
		        data: []
		    }]
		};
	var myChart2;
	$('#asRatioStatperDay').on("click", function() {
		var CTX = '${pageContext.request.contextPath}';
		var url = CTX + "/stat_qa_ratio.ap";
		console.log("asRatioStatperDay clicked.");
		myChart2 = new Highcharts.chart(options2);
		var sd = $('input[name=start_date]').val() ;// start_date
		var ed = $('input[name=end_date]').val() ;// end_date
		var params = { start_date: sd, end_date: ed,
				client_version: 0.33, name: 'honggil' }; // JSON obj
		//
		//$.post();
		$.ajax({
			type: 'post',
			//data: 'sd='+sd+"&ed="+ed, 
			data: JSON.stringify(params),  // JSON msg //<-->JSON.parse()
			url: url, 
			//dataType: 'text',
			contentType: 'application/json', 
			dataType: 'json',
			success: function(res, status, xhr) {
				console.log(res);
				var pieGraphName = res.pieName; 
				myChart2.series[0].setName(pieGraphName);
				myChart2.series[0].setData(res.pieData);
				//
				var ori = res.oriData;
				console.log(ori);
				for(var o = 0; o < ori.length; o++ ) {
					var li = "<li> ??????:" + ori[o].stDay +": "
						+ ", ????????????: " + ori[o].asCnt
						+ ", ??????????????????: " + ori[o].asRatio 
						+ ", ?????????: " + ori[o].cpSum 
						+ ", ???????????????: " + ori[o].cpRatio 
						+"</li>";
					console.log(li);
					$('#stat_report2').append(li);					
				}
			},
			error: function(xhr,status) { // ????????? ????????? ???????????? ???????????? ??? 3xx,4xx,5xx
				console.log("ERROR: " + status);  // error
				console.log("ERROR: " + xhr.status); // 400
			}
		});
	});	
	
}); // ready		
</script>

<div class="wrapper">
	<div class="wrap">
		<h1> admin ?????? </h1>
		<table class="piece">
			<tr>
				<th>??????????????? ??? ????????? ?????? :</th>
				<td style="text-align: center;">
					<input id="asStatperArticle" type="button" value="????????????">
				 </td>
			</tr>
			<tr>
				<td colspan="2"><figure class="highcharts-figure">
					<div id="stat_plot"></div>
					<p class="highcharts-description">
					</p>
				</figure>
				</td>
			</tr>
			<tr>
				<th colspan="2">?????? ??? ????????? ?????? ?????? : (????????????,??????????????????)</th>
			</tr>
			<tr>
				<td>
					?????????: <input type="date" name="start_date"> (??????)
					~
					?????????: <input type="date" name="end_date"> (??????)
				</td>
				<td style="text-align: center;">
					<input id="asRatioStatperDay" type="button"
				 value="????????????">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<figure class="highcharts-figure">
						<div id="stat_plot2"></div>
						<p class="highcharts-description">
						</p>
					</figure>
				</td>
			</tr>
		</table>
	</div>
</div>