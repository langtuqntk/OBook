$(document).ready(function() {
	$('#datatable1').DataTable({
		"dom": 'lCfrtip',
		"order": [],
		"language": {
			"lengthMenu": '_MENU_ entries per page',
			"search": '<i class="fa fa-search"></i>',
			"paginate": {
				"previous": '<i class="fa fa-angle-left"></i>',
				"next": '<i class="fa fa-angle-right"></i>'
			}
		}
	});

});
