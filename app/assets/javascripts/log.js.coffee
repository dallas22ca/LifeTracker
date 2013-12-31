init = ->
  if $("#full_graph").length
    chart = $("#full_graph").data("chart")
    options =
      tooltip:
        shared: true,
        crosshairs: true
        useHTML: true
        formatter: ->
          point = this.points[0].point
          s = "<b>#{point.date}</b><br><hr />"
          s += "#{point.notes}<br><hr />"
          $.each this.points, (i, point) ->
            s += "<span style=\"color: #{point.series.color}; \">#{point.series.name} : #{point.y}</span><br>"
          s
    $.extend chart, options
    $("#full_graph").highcharts chart
  
  if $("#start").length
    $("#start, #finish").datepicker
      dateFormat: "M d, yy"
    
$ ->
  init()
  
document.addEventListener "page:load", init