function DisableSpecificDates(date) {
		var string = jQuery.datepicker.formatDate('yy-mm-dd', date);
		return [ disableddates.indexOf(string) == -1 ];
	}
	$(function() {
		$("#startDate").datepicker({
			beforeShowDay : DisableSpecificDates,
			dateFormat : "yy-mm-dd",
			minDate : "-d"

		});
	});

	$(function() {
		$("#endDate").datepicker({
			beforeShowDay : DisableSpecificDates,
			dateFormat : "yy-mm-dd",
			minDate : "-d"

		});
	});

	//日期轉換字串
	function formatDate(date) {
		var d = new Date(date), month = '' + (d.getMonth() + 1), day = ''
				+ d.getDate(), year = d.getFullYear();

		if (month.length < 2)
			month = '0' + month;
		if (day.length < 2)
			day = '0' + day;

		return [ year, month, day ].join('-');
	}






	
	var startDate = "";
	var endDate = "";

	$("#startDate").change(function(e) {
		startDate = $("#startDate").datepicker("getDate");
		$('#endDate').datepicker('option', {

			minDate : new Date(startDate),
			
		});
		
	});

	$("#endDate").change(
			function(e) {
				endDate = $("#endDate").datepicker("getDate");
				var start_str = $.datepicker.formatDate(
						"yy-mm-dd", startDate);
				$('#startDate').datepicker('option', {
					
					maxDate : new Date(endDate)
				});
				
			});