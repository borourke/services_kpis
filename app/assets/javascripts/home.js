$(function () {
  var report_cards = $("#report_cards").data('reports')
  $('#my_report_cards').highcharts({
    chart: {
      type: 'column'
    },
    title: {
      text: 'Medals Count by Report Card Category'
    },
    xAxis: {
      categories: ['Job Medals', 'Project Medals', 
      'Technical Medals', 'Efficiency Medals']
    },
    yAxis: {
      min: 0,
      title: {
        text: 'Medal Count'
      }
    },
    tooltip: {
      headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
      pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
      '<td style="padding:0"><b>{point.y}</b></td></tr>',
      footerFormat: '</table>',
      shared: true,
      useHTML: true
    },
    plotOptions: {
      column: {
        pointPadding: 0.2,
        borderWidth: 0
      }
    },
    series: [{
      name: 'Gold',
      data: report_cards["gold"],
      color: '#FFCC00',
      dataLabels: {
        enabled: true,
        format: '{point.y}'
      }

    }, {
      name: 'Silver',
      data: report_cards["silver"],
      color: 'silver',
      dataLabels: {
        enabled: true,
        format: '{point.y}'
      }

    }, {
      name: 'Bronze',
      data: report_cards["bronze"],
      color: '#CC6633',
      dataLabels: {
        enabled: true,
        format: '{point.y}'
      }

    }, {
      name: 'None',
      data: report_cards["none"],
      color: 'red',
      dataLabels: {
        enabled: true,
        format: '{point.y}'
      }

    }, {
      name: 'N/A',
      data: report_cards["na"],
      color: 'black',
      dataLabels: {
        enabled: true,
        format: '{point.y}'
      }

    }]
  });
});

$(function () {
  var report_cards = $("#all_report_cards").data('reports')
  console.log(report_cards)
  $('#services_report_cards').highcharts({
    chart: {
      type: 'column'
    },
    title: {
      text: 'Medals Count by Report Card Category'
    },
    xAxis: {
      categories: ['Job Medals', 'Project Medals', 
      'Technical Medals', 'Efficiency Medals']
    },
    yAxis: {
      min: 0,
      title: {
        text: 'Medal Count'
      }
    },
    tooltip: {
      headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
      pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
      '<td style="padding:0"><b>{point.y}</b></td></tr>',
      footerFormat: '</table>',
      shared: true,
      useHTML: true
    },
    plotOptions: {
      column: {
        pointPadding: 0.2,
        borderWidth: 0
      }
    },
    series: [{
      name: 'Gold',
      data: report_cards["gold"],
      color: '#FFCC00',
      dataLabels: {
        enabled: true,
        format: '{point.y}'
      }

    }, {
      name: 'Silver',
      data: report_cards["silver"],
      color: 'silver',
      dataLabels: {
        enabled: true,
        format: '{point.y}'
      }

    }, {
      name: 'Bronze',
      data: report_cards["bronze"],
      color: '#CC6633',
      dataLabels: {
        enabled: true,
        format: '{point.y}'
      }

    }, {
      name: 'None',
      data: report_cards["none"],
      color: 'red',
      dataLabels: {
        enabled: true,
        format: '{point.y}'
      }

    }, {
      name: 'N/A',
      data: report_cards["na"],
      color: 'black',
      dataLabels: {
        enabled: true,
        format: '{point.y}'
      }

    }]
  });
});

$(function () {

  var gaugeOptions = {

   chart: {
    type: 'solidgauge'
  },

  title: null,

  pane: {
    center: ['50%', '85%'],
    size: '140%',
    startAngle: -90,
    endAngle: 90,
    background: {
     backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || '#EEE',
     innerRadius: '60%',
     outerRadius: '100%',
     shape: 'arc'
   }
 },

 tooltip: {
  enabled: false
},

    // the value axis
    yAxis: {
    	stops: [
            [0.25, '#DF5353'], // red
            [0.50, '#DDDF0D'], // yellow
            [0.75, '#55BF3B'] // green
            ],
            lineWidth: 0,
            minorTickInterval: null,
            tickPixelInterval: 400,
            tickWidth: 0,
            title: {
            	y: -160
            },
            labels: {
            	y: 16
            }
          },

          plotOptions: {
           solidgauge: {
            dataLabels: {
             y: 5,
             borderWidth: 0,
             useHTML: true
           }
         }
       }
     };

// The speed gauge
$('#happiness_gauge').highcharts(Highcharts.merge(gaugeOptions, {
	yAxis: {
		min: 0,
		max: 100,
		title: {
			text: '<span style="font-size:18px;color:black">Average Happiness This Month</span>'
		}
	},

	credits: {
		enabled: false
	},

	series: [{
		name: 'Speed',
		data: [<%= @this_months_happiness_average %>],
		dataLabels: {
			format: '<div style="text-align:center"><span style="font-size:25px;color:' +
			((Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black') + '">{y}</span><br/>' +
			'<span style="font-size:18px;color:black">Services Happiness</span></div>'
		},
		tooltip: {
			valueSuffix: 'Smiles :)'
}
}]

}));

});

$(function () {
  var medals_hash = $("#channing-is-fucking-awesome").data('medals');

// Medal Counts
$('#all_time_medals_chart').highcharts({
	chart: {
		type: 'column'
	},
	title: {
		text: 'Services All Time Medal Count'
	},
	xAxis: {
		type: 'category',
		categories: [
		'Gold', 
		'Silver', 
		'Bronze', 
		'None', 
		'N/A'
		]
	},
	yAxis: {
		min: 0,
		title: {
			text: 'Medal Count'
		}
	},
	tooltip: {
		headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
		pointFormat: '<tr><td padding:0">{series.name}: </td>' +
		'<td style="padding:0"><b>{point.y}</b></td></tr>',
		footerFormat: '</table>',
		shared: true,
		useHTML: true
	},
	plotOptions: {
		column: {
			pointPadding: 0.2,
			borderWidth: 0
		}
	},
	series: [{
		name: 'Medals',
		data: [{y: medals_hash['Gold'], color: '#FFCC00'}, {y: medals_hash['Silver'], color: 'silver'}, {y: medals_hash['Bronze'], color: '#CC6633'}, {y: medals_hash['None'], color: 'red'}, {y: medals_hash['N/A'], color: 'black'}],
		color: 'white',
		dataLabels: {
			enabled: true,
			format: '{point.y}'
		}
	}],
	legend: {
		enabled: false
	},
});

});

$(function () {
  var medals_hash = $("#medals_array").data('medals');
  var user_name = $("#user_name").data('user');

// Medal Counts
$('#my_medals_chart').highcharts({
  chart: {
    type: 'column'
  },
  title: {
    text: user_name + "'s All Time Medal Count"
  },
  xAxis: {
    type: 'category',
    categories: [
    'Gold', 
    'Silver', 
    'Bronze', 
    'None', 
    'N/A'
    ]
  },
  yAxis: {
    min: 0,
    title: {
      text: 'Medal Count'
    }
  },
  tooltip: {
    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
    pointFormat: '<tr><td padding:0">{series.name}: </td>' +
    '<td style="padding:0"><b>{point.y}</b></td></tr>',
    footerFormat: '</table>',
    shared: true,
    useHTML: true
  },
  plotOptions: {
    column: {
      pointPadding: 0.2,
      borderWidth: 0
    }
  },
  series: [{
    name: 'Medals',
    data: [{y: medals_hash['Gold'], color: '#FFCC00'}, {y: medals_hash['Silver'], color: 'silver'}, {y: medals_hash['Bronze'], color: '#CC6633'}, {y: medals_hash['None'], color: 'red'}, {y: medals_hash['N/A'], color: 'black'}],
    color: 'white',
    dataLabels: {
      enabled: true,
      format: '{point.y}'
    }
  }],
  legend: {
    enabled: false
  },
});

});

$(function () {
  var month_medals_hash = $("#month_medals_hash").data('medals');
  console.log(month_medals_hash)
  $('#month_medals_chart').highcharts({
    chart: {
      type: 'column'
    },
    title: {
      text: 'Medals Count by Month'
    },
    subtitle: {
      text: 'Last 12 Months'
    },
    xAxis: {
      categories: month_medals_hash["months"]
    },
    yAxis: {
      min: 0,
      title: {
        text: 'Medals Count'
      }
    },
    tooltip: {
      headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
      pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
      '<td style="padding:0"><b>{point.y}</b></td></tr>',
      footerFormat: '</table>',
      shared: true,
      useHTML: true
    },
    plotOptions: {
      column: {
        pointPadding: 0.2,
        borderWidth: 0
      }
    },
    series: [{
      name: 'Gold',
      data: month_medals_hash["medals_count"]["Gold"],    
      color: '#FFCC00'

    }, {
      name: 'Silver',
      data: month_medals_hash["medals_count"]["Silver"],
      color: 'silver'

    }, {
      name: 'Bronze',
      data: month_medals_hash["medals_count"]["Bronze"],
      color: '#CC6633'

    }, {
      name: 'None',
      data: month_medals_hash["medals_count"]["None"],
      color: 'red'

    }, {
      name: 'N/A',
      data: month_medals_hash["medals_count"]["N/A"],
      color: 'black'

    }]
  });
});

$(function () {
  var month_medals_hash = $("#my_month_medals_hash").data('medals');
  console.log(month_medals_hash)
  $('#my_month_medals_chart').highcharts({
    chart: {
      type: 'column'
    },
    title: {
      text: 'Medals Count by Month'
    },
    subtitle: {
      text: 'Last 12 Months'
    },
    xAxis: {
      categories: month_medals_hash["months"]
    },
    yAxis: {
      min: 0,
      title: {
        text: 'Medals Count'
      }
    },
    tooltip: {
      headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
      pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
      '<td style="padding:0"><b>{point.y}</b></td></tr>',
      footerFormat: '</table>',
      shared: true,
      useHTML: true
    },
    plotOptions: {
      column: {
        pointPadding: 0.2,
        borderWidth: 0
      }
    },
    series: [{
      name: 'Gold',
      data: month_medals_hash["medals_count"]["Gold"],    
      color: '#FFCC00',
      dataLabels: {
        enabled: true,
        format: '{point.y}'
      }

    }, {
      name: 'Silver',
      data: month_medals_hash["medals_count"]["Silver"],
      color: 'silver',
      dataLabels: {
        enabled: true,
        format: '{point.y}'
      }

    }, {
      name: 'Bronze',
      data: month_medals_hash["medals_count"]["Bronze"],
      color: '#CC6633',
      dataLabels: {
        enabled: true,
        format: '{point.y}'
      }

    }, {
      name: 'None',
      data: month_medals_hash["medals_count"]["None"],
      color: 'red',
      dataLabels: {
        enabled: true,
        format: '{point.y}'
      }

    }, {
      name: 'N/A',
      data: month_medals_hash["medals_count"]["N/A"],
      color: 'black',
      dataLabels: {
        enabled: true,
        format: '{point.y}'
      }

    }]
  });
});

$(function () {
  var happiness_by_month_drilldown = $('#happiness_by_month_hash').data('happiness');
  var happiness_by_category = $('#happiness_by_category').data('happiness2');
  console.log(happiness_by_month_drilldown);
  console.log(happiness_by_category);

            // Create the chart
            $('#happiness_by_month').highcharts({
              chart: {
                type: 'column'
              },
              title: {
                text: 'Services Happiness by Month'
              },
              subtitle: {
                text: 'Click the columns to view happiness by category for that month.'
              },
              xAxis: {
                type: 'category'
              },
              yAxis: {
                title: {
                  text: 'Happiness Percent'
                },
                min: 0,
                max: 100
              },
              legend: {
                enabled: false
              },
              plotOptions: {
                series: {
                  borderWidth: 0,
                  dataLabels: {
                    enabled: true,
                    format: '{point.y}%'
                  }
                }
              },

              tooltip: {
                headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
                pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y}</b><br/>'
              },

              series: [{
                name: 'Happiness',
                colorByPoint: true,
                data: happiness_by_month_drilldown
              }],
              drilldown: {
                series: happiness_by_category
              }
            });

});