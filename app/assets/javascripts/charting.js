var previousPoint = null;
var previousLabel = null;
function donationsThisYearWidget(data) {
    $('.donation-total-widget').html('<strong>Jan. $'+data[0][1]+'.00</strong>');
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
                return "$"+v;
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

                $('.donation-total-widget').html('<strong>'+item.series.xaxis.ticks[x].label+' $'+y+'.00</strong>');
            }
        } else {
            previousPoint = null;
        }
    });
};