<%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <html lang="en-us">
        <jsp:include page="../pages/common/header.jsp" />
        <!--

	TABLE OF CONTENTS.
	
	Use search to find needed section.
	
	===================================================================
	
	|  01. #CSS Links                |  all CSS links and file paths  |
	|  02. #FAVICONS                 |  Favicon links and file paths  |
	|  03. #GOOGLE FONT              |  Google font link              |
	|  04. #APP SCREEN / ICONS       |  app icons, screen backdrops   |
	|  05. #BODY                     |  body tag                      |
	|  06. #HEADER                   |  header tag                    |
	|  07. #PROJECTS                 |  project lists                 |
	|  08. #TOGGLE LAYOUT BUTTONS    |  layout buttons and actions    |
	|  09. #MOBILE                   |  mobile view dropdown          |
	|  10. #SEARCH                   |  search field                  |
	|  11. #NAVIGATION               |  left panel & navigation       |
	|  12. #RIGHT PANEL              |  right panel userlist          |
	|  13. #MAIN PANEL               |  main panel                    |
	|  14. #MAIN CONTENT             |  content holder                |
	|  15. #PAGE FOOTER              |  page footer                   |
	|  16. #SHORTCUT AREA            |  dropdown shortcuts area       |
	|  17. #PLUGINS                  |  all scripts and plugins       |
	
	===================================================================
	
	-->
        <!-- #BODY -->
        <!-- Possible Classes

		* 'smart-style-{SKIN#}'
		* 'smart-rtl'         - Switch theme mode to RTL
		* 'menu-on-top'       - Switch to top navigation (no DOM change required)
		* 'no-menu'			  - Hides the menu completely
		* 'hidden-menu'       - Hides the main menu but still accessable by hovering over left edge
		* 'fixed-header'      - Fixes the header
		* 'fixed-navigation'  - Fixes the main menu
		* 'fixed-ribbon'      - Fixes breadcrumb
		* 'fixed-page-footer' - Fixes footer
		* 'container'         - boxed layout mode (non-responsive: will not work with fixed-navigation & fixed-ribbon)
	-->

        <body class="fixed-page-footer">
            <jsp:include page="../pages/common/menu-top.jsp" />
            <jsp:include page="../pages/common/menu-left.jsp" />
            <!-- MAIN PANEL -->
            <div id="main" role="main">
                <!-- RIBBON -->
                <div id="ribbon">
                    <span class="ribbon-button-alignment"> 
					<span id="refresh" class="btn btn-ribbon" data-action="resetWidgets" data-title="refresh"  rel="tooltip" data-placement="bottom" data-original-title="<i class='text-warning fa fa-warning'></i> Warning! This will reset all your widget settings." data-html="true">
						<i class="fa fa-refresh"></i>
					</span>
                    </span>
                    <!-- breadcrumb -->
                    <ol class="breadcrumb">
                        <li>Home</li>
                        <li>Buyer</li>
                    </ol>
                    <!-- end breadcrumb -->
                    <!-- You can also add more buttons to the
				ribbon for further usability

				Example below:

				<span class="ribbon-button-alignment pull-right">
				<span id="search" class="btn btn-ribbon hidden-xs" data-title="search"><i class="fa-grid"></i> Change Grid</span>
				<span id="add" class="btn btn-ribbon hidden-xs" data-title="add"><i class="fa-plus"></i> Add</span>
				<span id="search" class="btn btn-ribbon" data-title="search"><i class="fa-search"></i> <span class="hidden-mobile">Search</span></span>
				</span> -->
                </div>
                <!-- END RIBBON -->
                <!-- MAIN CONTENT -->
                <div class="col-lg-12" style=" display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 15px; padding-bottom: 100px;
">
                    <div class="row" width="100%">
                        <div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-3" data-widget-editbutton="false">
                            <header>
                                <h1><b>Buyer requirements</b></h1>
                            </header>
                            <div>
                                <div class="jarviswidget-editbox"></div>
                                <div id="content" class="widget-body " width="100%">
                                    <!-- widget grid -->
                                    <section id="widget-grid" class="row">
                                        <h1><b>Buyer requirements</b></h1>
                                        <hr/>
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox" class="checkbox style-0">
                                                <span>Don't have PayPal accountPayPal account holders have up to an 80% lower Unpaid Item rate.</span>
                                            </label>
                                        </div>
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox" class="checkbox style-0" checked="checked">
                                                <span>Have received 
								<select>
									<option value="0">2</option>
									<option value="1">3</option>
									<option value="2">4</option>
									<option value="3">5</option>
								</select><i></i> 
										unpaid item case(s) within 
								<select>
									<option value="0">1</option>
									<option value="1">6</option>
									<option value="2">12</option>
								</select><i></i> month(s)</span>
                                            </label>
                                        </div>
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox" class="checkbox style-0" checked="checked">
                                                <span>Have a primary shipping address in countries that I don't ship to</span>
                                            </label>
                                        </div>
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox" class="checkbox style-0" checked="checked">
                                                <span>Have policy violation report(s) wihtinmonth(s).</span>
                                            </label>
                                        </div>
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox" class="checkbox style-0" checked="checked">
                                                <span>Have a feedback score equal to or lower than </span>
                                            </label>
                                        </div>
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox" class="checkbox style-0" checked="checked">
                                                <span>Have bid on or bought my items within the last 10 days and met my limit of</span>
                                            </label>
                                        </div>
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox" class="checkbox style-0" checked="checked">
                                                <span>Only apply this block to buyers who have a feedback score equal to or lower than. Control the number of items a single buyer can purchase.</span>
                                            </label>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <button class="btn btn-success">Update</button>
                                            </div>
                                        </div>
                                    </section>
                                    <!-- end widget grid -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </div>
            <!-- END MAIN CONTENT -->
            </div>
            <jsp:include page="../pages/common/footer.jsp" />
            <!--================================================== -->
            <jsp:include page="../pages/common/footer2.jsp" />
            <style type="text/css">
            .jarviswidget>header {
                height: 50px;
                padding: 0;
                padding-left: 13px;
                line-height: 40px;
            }
            </style>
            <script>
            $(document).ready(function() {

                // DO NOT REMOVE : GLOBAL FUNCTIONS!
                pageSetUp();

                /*
                 * PAGE RELATED SCRIPTS
                 */

                $(".js-status-update a").click(function() {
                    var selText = $(this).text();
                    var $this = $(this);
                    $this.parents('.btn-group').find('.dropdown-toggle').html(selText + ' <span class="caret"></span>');
                    $this.parents('.dropdown-menu').find('li').removeClass('active');
                    $this.parent().addClass('active');
                });

                /*
                 * TODO: add a way to add more todo's to list
                 */

                // initialize sortable
                $(function() {
                    $("#sortable1, #sortable2").sortable({
                        handle: '.handle',
                        connectWith: ".todo",
                        update: countTasks
                    }).disableSelection();
                });

                // check and uncheck
                $('.todo .checkbox > input[type="checkbox"]').click(function() {
                        var $this = $(this).parent().parent().parent();

                        if ($(this).prop('checked')) {
                            $this.addClass("complete");

                            // remove this if you want to undo a check list once checked
                            //$(this).attr("disabled", true);
                            $(this).parent().hide();

                            // once clicked - add class, copy to memory then remove and add to sortable3
                            $this.slideUp(500, function() {
                                $this.clone().prependTo("#sortable3").effect("highlight", {}, 800);
                                $this.remove();
                                countTasks();
                            });
                        } else {
                            // insert undo code here...
                        }

                    })
                    // count tasks
                function countTasks() {

                    $('.todo-group-title').each(function() {
                        var $this = $(this);
                        $this.find(".num-of-tasks").text($this.next().find("li").size());
                    });

                }

                /*
                 * RUN PAGE GRAPHS
                 */

                /* TAB 1: UPDATING CHART */
                // For the demo we use generated data, but normally it would be coming from the server

                var data = [],
                    totalPoints = 200,
                    $UpdatingChartColors = $("#updating-chart").css('color');

                function getRandomData() {
                    if (data.length > 0)
                        data = data.slice(1);

                    // do a random walk
                    while (data.length < totalPoints) {
                        var prev = data.length > 0 ? data[data.length - 1] : 50;
                        var y = prev + Math.random() * 10 - 5;
                        if (y < 0)
                            y = 0;
                        if (y > 100)
                            y = 100;
                        data.push(y);
                    }

                    // zip the generated y values with the x values
                    var res = [];
                    for (var i = 0; i < data.length; ++i)
                        res.push([i, data[i]])
                    return res;
                }

                // setup control widget
                var updateInterval = 1500;
                $("#updating-chart").val(updateInterval).change(function() {

                    var v = $(this).val();
                    if (v && !isNaN(+v)) {
                        updateInterval = +v;
                        $(this).val("" + updateInterval);
                    }

                });

                // setup plot
                var options = {
                    yaxis: {
                        min: 0,
                        max: 100
                    },
                    xaxis: {
                        min: 0,
                        max: 100
                    },
                    colors: [$UpdatingChartColors],
                    series: {
                        lines: {
                            lineWidth: 1,
                            fill: true,
                            fillColor: {
                                colors: [{
                                    opacity: 0.4
                                }, {
                                    opacity: 0
                                }]
                            },
                            steps: false

                        }
                    }
                };

                var plot = $.plot($("#updating-chart"), [getRandomData()], options);

                /* live switch */
                $('input[type="checkbox"]#start_interval').click(function() {
                    if ($(this).prop('checked')) {
                        $on = true;
                        updateInterval = 1500;
                        update();
                    } else {
                        clearInterval(updateInterval);
                        $on = false;
                    }
                });

                function update() {
                    if ($on == true) {
                        plot.setData([getRandomData()]);
                        plot.draw();
                        setTimeout(update, updateInterval);

                    } else {
                        clearInterval(updateInterval)
                    }

                }

                var $on = false;

                /*end updating chart*/

                /* TAB 2: Social Network  */

                $(function() {
                    // jQuery Flot Chart
                    var twitter = [
                            [1, 27],
                            [2, 34],
                            [3, 51],
                            [4, 48],
                            [5, 55],
                            [6, 65],
                            [7, 61],
                            [8, 70],
                            [9, 65],
                            [10, 75],
                            [11, 57],
                            [12, 59],
                            [13, 62]
                        ],
                        facebook = [
                            [1, 25],
                            [2, 31],
                            [3, 45],
                            [4, 37],
                            [5, 38],
                            [6, 40],
                            [7, 47],
                            [8, 55],
                            [9, 43],
                            [10, 50],
                            [11, 47],
                            [12, 39],
                            [13, 47]
                        ],
                        data = [{
                            label: "Twitter",
                            data: twitter,
                            lines: {
                                show: true,
                                lineWidth: 1,
                                fill: true,
                                fillColor: {
                                    colors: [{
                                        opacity: 0.1
                                    }, {
                                        opacity: 0.13
                                    }]
                                }
                            },
                            points: {
                                show: true
                            }
                        }, {
                            label: "Facebook",
                            data: facebook,
                            lines: {
                                show: true,
                                lineWidth: 1,
                                fill: true,
                                fillColor: {
                                    colors: [{
                                        opacity: 0.1
                                    }, {
                                        opacity: 0.13
                                    }]
                                }
                            },
                            points: {
                                show: true
                            }
                        }];

                    var options = {
                        grid: {
                            hoverable: true
                        },
                        colors: ["#568A89", "#3276B1"],
                        tooltip: true,
                        tooltipOpts: {
                            //content : "Value <b>$x</b> Value <span>$y</span>",
                            defaultTheme: false
                        },
                        xaxis: {
                            ticks: [
                                [1, "JAN"],
                                [2, "FEB"],
                                [3, "MAR"],
                                [4, "APR"],
                                [5, "MAY"],
                                [6, "JUN"],
                                [7, "JUL"],
                                [8, "AUG"],
                                [9, "SEP"],
                                [10, "OCT"],
                                [11, "NOV"],
                                [12, "DEC"],
                                [13, "JAN+1"]
                            ]
                        },
                        yaxes: {

                        }
                    };

                    var plot3 = $.plot($("#statsChart"), data, options);
                });

                // END TAB 2

                // TAB THREE GRAPH //
                /* TAB 3: Revenew  */

                $(function() {

                    var trgt = [
                            [1354586000000, 153],
                            [1364587000000, 658],
                            [1374588000000, 198],
                            [1384589000000, 663],
                            [1394590000000, 801],
                            [1404591000000, 1080],
                            [1414592000000, 353],
                            [1424593000000, 749],
                            [1434594000000, 523],
                            [1444595000000, 258],
                            [1454596000000, 688],
                            [1464597000000, 364]
                        ],
                        prft = [
                            [1354586000000, 53],
                            [1364587000000, 65],
                            [1374588000000, 98],
                            [1384589000000, 83],
                            [1394590000000, 980],
                            [1404591000000, 808],
                            [1414592000000, 720],
                            [1424593000000, 674],
                            [1434594000000, 23],
                            [1444595000000, 79],
                            [1454596000000, 88],
                            [1464597000000, 36]
                        ],
                        sgnups = [
                            [1354586000000, 647],
                            [1364587000000, 435],
                            [1374588000000, 784],
                            [1384589000000, 346],
                            [1394590000000, 487],
                            [1404591000000, 463],
                            [1414592000000, 479],
                            [1424593000000, 236],
                            [1434594000000, 843],
                            [1444595000000, 657],
                            [1454596000000, 241],
                            [1464597000000, 341]
                        ],
                        toggles = $("#rev-toggles"),
                        target = $("#flotcontainer");

                    var data = [{
                        label: "Target Profit",
                        data: trgt,
                        bars: {
                            show: true,
                            align: "center",
                            barWidth: 30 * 30 * 60 * 1000 * 80
                        }
                    }, {
                        label: "Actual Profit",
                        data: prft,
                        color: '#3276B1',
                        lines: {
                            show: true,
                            lineWidth: 3
                        },
                        points: {
                            show: true
                        }
                    }, {
                        label: "Actual Signups",
                        data: sgnups,
                        color: '#71843F',
                        lines: {
                            show: true,
                            lineWidth: 1
                        },
                        points: {
                            show: true
                        }
                    }]

                    var options = {
                        grid: {
                            hoverable: true
                        },
                        tooltip: true,
                        tooltipOpts: {
                            //content: '%x - %y',
                            //dateFormat: '%b %y',
                            defaultTheme: false
                        },
                        xaxis: {
                            mode: "time"
                        },
                        yaxes: {
                            tickFormatter: function(val, axis) {
                                return "$" + val;
                            },
                            max: 1200
                        }

                    };

                    plot2 = null;

                    function plotNow() {
                        var d = [];
                        toggles.find(':checkbox').each(function() {
                            if ($(this).is(':checked')) {
                                d.push(data[$(this).attr("name").substr(4, 1)]);
                            }
                        });
                        if (d.length > 0) {
                            if (plot2) {
                                plot2.setData(d);
                                plot2.draw();
                            } else {
                                plot2 = $.plot(target, d, options);
                            }
                        }

                    };

                    toggles.find(':checkbox').on('change', function() {
                        plotNow();
                    });
                    plotNow()

                });

                /*
                 * VECTOR MAP
                 */

                data_array = {
                    "US": 4977,
                    "AU": 4873,
                    "IN": 3671,
                    "BR": 2476,
                    "TR": 1476,
                    "CN": 146,
                    "CA": 134,
                    "BD": 100
                };

                $('#vector-map').vectorMap({
                    map: 'world_mill_en',
                    backgroundColor: '#fff',
                    regionStyle: {
                        initial: {
                            fill: '#c4c4c4'
                        },
                        hover: {
                            "fill-opacity": 1
                        }
                    },
                    series: {
                        regions: [{
                            values: data_array,
                            scale: ['#85a8b6', '#4d7686'],
                            normalizeFunction: 'polynomial'
                        }]
                    },
                    onRegionLabelShow: function(e, el, code) {
                        if (typeof data_array[code] == 'undefined') {
                            e.preventDefault();
                        } else {
                            var countrylbl = data_array[code];
                            el.html(el.html() + ': ' + countrylbl + ' visits');
                        }
                    }
                });

                /*
                 * FULL CALENDAR JS
                 */

                if ($("#calendar").length) {
                    var date = new Date();
                    var d = date.getDate();
                    var m = date.getMonth();
                    var y = date.getFullYear();

                    var calendar = $('#calendar').fullCalendar({

                        editable: true,
                        draggable: true,
                        selectable: false,
                        selectHelper: true,
                        unselectAuto: false,
                        disableResizing: false,
                        height: "auto",

                        header: {
                            left: 'title', //,today
                            center: 'prev, next, today',
                            right: 'month, agendaWeek, agenDay' //month, agendaDay,
                        },

                        select: function(start, end, allDay) {
                            var title = prompt('Event Title:');
                            if (title) {
                                calendar.fullCalendar('renderEvent', {
                                        title: title,
                                        start: start,
                                        end: end,
                                        allDay: allDay
                                    }, true // make the event "stick"
                                );
                            }
                            calendar.fullCalendar('unselect');
                        },

                        events: [{
                            title: 'All Day Event',
                            start: new Date(y, m, 1),
                            description: 'long description',
                            className: ["event", "bg-color-greenLight"],
                            icon: 'fa-check'
                        }, {
                            title: 'Long Event',
                            start: new Date(y, m, d - 5),
                            end: new Date(y, m, d - 2),
                            className: ["event", "bg-color-red"],
                            icon: 'fa-lock'
                        }, {
                            id: 999,
                            title: 'Repeating Event',
                            start: new Date(y, m, d - 3, 16, 0),
                            allDay: false,
                            className: ["event", "bg-color-blue"],
                            icon: 'fa-clock-o'
                        }, {
                            id: 999,
                            title: 'Repeating Event',
                            start: new Date(y, m, d + 4, 16, 0),
                            allDay: false,
                            className: ["event", "bg-color-blue"],
                            icon: 'fa-clock-o'
                        }, {
                            title: 'Meeting',
                            start: new Date(y, m, d, 10, 30),
                            allDay: false,
                            className: ["event", "bg-color-darken"]
                        }, {
                            title: 'Lunch',
                            start: new Date(y, m, d, 12, 0),
                            end: new Date(y, m, d, 14, 0),
                            allDay: false,
                            className: ["event", "bg-color-darken"]
                        }, {
                            title: 'Birthday Party',
                            start: new Date(y, m, d + 1, 19, 0),
                            end: new Date(y, m, d + 1, 22, 30),
                            allDay: false,
                            className: ["event", "bg-color-darken"]
                        }, {
                            title: 'Smartadmin Open Day',
                            start: new Date(y, m, 28),
                            end: new Date(y, m, 29),
                            className: ["event", "bg-color-darken"]
                        }],


                        eventRender: function(event, element, icon) {
                            if (!event.description == "") {
                                element.find('.fc-title').append("<br/><span class='ultra-light'>" + event.description + "</span>");
                            }
                            if (!event.icon == "") {
                                element.find('.fc-title').append("<i class='air air-top-right fa " + event.icon + " '></i>");
                            }
                        }
                    });

                };

                /* hide default buttons */
                $('.fc-toolbar .fc-right, .fc-toolbar .fc-center').hide();

                // calendar prev
                $('#calendar-buttons #btn-prev').click(function() {
                    $('.fc-prev-button').click();
                    return false;
                });

                // calendar next
                $('#calendar-buttons #btn-next').click(function() {
                    $('.fc-next-button').click();
                    return false;
                });

                // calendar today
                $('#calendar-buttons #btn-today').click(function() {
                    $('.fc-button-today').click();
                    return false;
                });

                // calendar month
                $('#mt').click(function() {
                    $('#calendar').fullCalendar('changeView', 'month');
                });

                // calendar agenda week
                $('#ag').click(function() {
                    $('#calendar').fullCalendar('changeView', 'agendaWeek');
                });

                // calendar agenda day
                $('#td').click(function() {
                    $('#calendar').fullCalendar('changeView', 'agendaDay');
                });

                /*
                 * CHAT
                 */

                $.filter_input = $('#filter-chat-list');
                $.chat_users_container = $('#chat-container > .chat-list-body')
                $.chat_users = $('#chat-users')
                $.chat_list_btn = $('#chat-container > .chat-list-open-close');
                $.chat_body = $('#chat-body');

                /*
                 * LIST FILTER (CHAT)
                 */

                // custom css expression for a case-insensitive contains()
                jQuery.expr[':'].Contains = function(a, i, m) {
                    return (a.textContent || a.innerText || "").toUpperCase().indexOf(m[3].toUpperCase()) >= 0;
                };

                function listFilter(list) { // header is any element, list is an unordered list
                    // create and add the filter form to the header

                    $.filter_input.change(function() {
                        var filter = $(this).val();
                        if (filter) {
                            // this finds all links in a list that contain the input,
                            // and hide the ones not containing the input while showing the ones that do
                            $.chat_users.find("a:not(:Contains(" + filter + "))").parent().slideUp();
                            $.chat_users.find("a:Contains(" + filter + ")").parent().slideDown();
                        } else {
                            $.chat_users.find("li").slideDown();
                        }
                        return false;
                    }).keyup(function() {
                        // fire the above change event after every letter
                        $(this).change();

                    });

                }

                // on dom ready
                listFilter($.chat_users);

                // open chat list
                $.chat_list_btn.click(function() {
                    $(this).parent('#chat-container').toggleClass('open');
                })

                $.chat_body.animate({
                    scrollTop: $.chat_body[0].scrollHeight
                }, 500);

            });
            $('input.toggleAll').change(function() {
                var checked = $(this).prop("checked");
                $(this).closest('.region').find('ul input').prop('checked', checked);
                updateListCountriesNotShipping();
            });
            $('input[name=country]').click(function() {
                var region = $(this).closest('.region');
                var count = 0;
                $('input[name=country]', region).each(function() {
                    count++;
                    var checked = $(this).prop('checked');
                    if (checked) {
                        count--;
                    };
                });
                $('input.toggleAll', region).prop('checked', count == 0);
                updateListCountriesNotShipping();
            })

            function updateListCountriesNotShipping() {
                var container = $('#countriesNotShipping');
                container.html('');
                $('')
                $('input.toggleAll').each(function() {

                    var checked = $(this).prop('checked');
                    var span = document.createElement('span');
                    var region = $(this).attr('data-region');
                    if (checked) {
                        $(span).html(region);
                        $(container).append(span);
                        $(container).append('<span>,</span>');
                    } else {
                        var divRegion = $(this).closest('.region');
                        $('input[name=country]', divRegion).each(function() {
                            var span2 = document.createElement('span');
                            var country = $(this).attr('data-country');

                            var checked2 = $(this).prop('checked');
                            if (checked2) {
                                $(span2).html(country);
                                $(container).append(span2);
                                $(container).append('<span>,</span>');
                            }
                        });
                    }
                });
                $('span:last-child', container).remove();

            }
            </script>
            <!-- Your GOOGLE ANALYTICS CODE Below -->
            <script type="text/javascript">
            var _gaq = _gaq || [];
            _gaq.push(['_setAccount', 'UA-XXXXXXXX-X']);
            _gaq.push(['_trackPageview']);

            (function() {
                var ga = document.createElement('script');
                ga.type = 'text/javascript';
                ga.async = true;
                ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
                var s = document.getElementsByTagName('script')[0];
                s.parentNode.insertBefore(ga, s);
            })();
            </script>
        </body>

        </html>
