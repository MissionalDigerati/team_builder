var previousPoint = null;
var previousLabel = null;
var previousYearlyPoint = null;
var previousYearlyLabel = null;
function donationsThisYearWidget(data) {
    $('.donation-total-widget').html('<strong>Jan. '+toCurrency(data[0][1])+'</strong>');
    var donationDatasets = [
        { label: "Donations Received", data: data, color: "#5482FF" }
    ];

    var monthTicks = [
        [0, "Jan."],
        [1, "Feb."],
        [2, "Mar."],
        [3, "Apr."],
        [4, "May"],
        [5, "June"],
        [6, 'July'],
        [7, 'Aug.'],
        [8, 'Sept.'],
        [9, 'Oct.'],
        [10, 'Nov.'],
        [11, 'Dec.']
    ];

    var donationOptions = {
        series: {
            bars: {
                show: true
            }
        },
        bars: {
            align: "center",
            barWidth: 0.5
        },
        xaxis: {
            ticks: monthTicks,
            axisLabel: "Month",
            axisLabelUseCanvas: true,
            axisLabelFontSizePixels: 12,
            axisLabelFontFamily: 'Verdana, Arial',
            axisLabelPadding: 10
        },
        yaxis: {
            axisLabel: "Total Donations",
            axisLabelUseCanvas: true,
            axisLabelFontSizePixels: 12,
            axisLabelFontFamily: 'Verdana, Arial',
            axisLabelPadding: 3,
            tickFormatter: function (v, axis) {
                return toCurrency(v);
            }
        },
        grid: {
            hoverable: true,
            borderWidth: 2,
            backgroundColor: { colors: ["#ffffff", "#EDF5FF"] }
        }
    };

    $.plot($("#donation-summary-wiget"), donationDatasets, donationOptions);
    $("#donation-summary-wiget").bind("plothover", function (event, pos, item) {
        if (item) {
            if ((previousLabel != item.series.label) || (previousPoint != item.dataIndex)) {
                previousPoint = item.dataIndex;
                previousLabel = item.series.label;

                var x = item.datapoint[0];
                var y = item.datapoint[1];

                $('.donation-total-widget').html('<strong>'+item.series.xaxis.ticks[x].label+' '+toCurrency(y)+'</strong>');
            }
        } else {
            previousPoint = null;
        }
    });
};
function donationsYearlyWidget(data) {
    yearTicks = new Array();
    dataArray = new Array();
    i = 0;
    $.each(data, function(key, val) {
        if (i == 0) {
            $('.donation-yearly-total-widget').html('<strong>'+key+' - '+toCurrency(val)+'</strong>');
        };
        yearTicks.push([i, key]);
        dataArray.push([i, val]);
        i++;
    });
    var donationDatasets = [
        { label: "Donations Received", data: dataArray, color: "#4ac344" }
    ];

    var donationOptions = {
        series: {
            bars: {
                show: true
            }
        },
        bars: {
            align: "center",
            barWidth: 0.5
        },
        xaxis: {
            ticks: yearTicks,
            axisLabel: "Year",
            axisLabelUseCanvas: true,
            axisLabelFontSizePixels: 12,
            axisLabelFontFamily: 'Verdana, Arial',
            axisLabelPadding: 10
        },
        yaxis: {
            axisLabel: "Total Donations",
            axisLabelUseCanvas: true,
            axisLabelFontSizePixels: 12,
            axisLabelFontFamily: 'Verdana, Arial',
            axisLabelPadding: 3,
            tickFormatter: function (v, axis) {
                return toCurrency(v);
            }
        },
        grid: {
            hoverable: true,
            borderWidth: 2,
            backgroundColor: { colors: ["#ffffff", "#EDF5FF"] }
        }
    };

    $.plot($("#donation-yearly-summary-wiget"), donationDatasets, donationOptions);
    $("#donation-yearly-summary-wiget").bind("plothover", function (event, pos, item) {
        if (item) {
            if ((previousYearlyLabel != item.series.label) || (previousYearlyPoint != item.dataIndex)) {
                previousYearlyPoint = item.dataIndex;
                previousYearlyLabel = item.series.label;

                var x = item.datapoint[0];
                var y = item.datapoint[1];

                $('.donation-yearly-total-widget').html('<strong>'+item.series.xaxis.ticks[x].label+' - '+toCurrency(y)+'</strong>');
            }
        } else {
            previousYearlyPoint = null;
        }
    });
};
function tasksSummaryWidget(data) {
    $.plot('#tasks-summary-wiget', data, {
        series: {
            pie: {
                show: true
            }
        }
    });
};
function teamStatusSummaryWidget(data) {
    $.plot('#team-status-summary-wiget', data, {
        series: {
            pie: {
                show: true
            }
        }
    });
};
function toCurrency(amount) {
    return '$' + parseFloat(amount, 10).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, "$1,").toString();
};