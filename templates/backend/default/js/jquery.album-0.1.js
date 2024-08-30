var random = Math.random();
function selectChange(img, selection) {
    document.getElementById("x1").value = selection.x1;
    document.getElementById("y1").value = selection.y1;
    document.getElementById("x2").value = selection.x2;
    document.getElementById("y2").value = selection.y2;
    document.getElementById("width").value = selection.width;
    document.getElementById("height").value = selection.height;
}
            
$(document).ready(function(){
    $("#random").val(random);
    $("img[id*='album_photo_']").click(function(event) {
        event.preventDefault();
        var photo_id    = $(this).attr('id');
        var id_split    = photo_id.split('_');
        var photo_nr    = id_split[2];
        $("input[name='photo']").val(photo_nr);
        $.post(base_url + '/ajax/album_cover', { PID: photo_nr, random: random },
            function(response) {
                if ( response.status ) {
                    var cover_url   = base_url + '/tmp/albums/' + photo_nr + '_' + random + '.jpg';
                    $('img#album_cover').attr('src', cover_url);
                    $('img#album_cover').attr('width', response.width);
                    $('img#album_cover').attr('height', response.height);

					var iw = response.width;
					var ih = response.height;
					var s_max = iw;
					var s_x = 0;
					var s_y = 0;
					
					
					if ( ih < iw ) {
						s_max = ih;
						s_x = Math.floor((iw - s_max)/2);
					}
					else {
					s_y = Math.floor((ih - s_max)/2);
					}
					$('#current_cover').hide();
					$("#x1").val( s_x );
					$("#y1").val( s_y );
					$("#x2").val( s_x + s_max );
					$("#y2").val( s_y + s_max );
					$("#width").val( s_max );
					$("#height").val( s_max );

					$("#x1-i").val( s_x );
					$("#y1-i").val( s_y );
					$("#x2-i").val( s_x + s_max );
					$("#y2-i").val( s_y + s_max );
					$("#width-i").val( s_max );
					$("#height-i").val( s_max );
					
					$('img#album_cover').imgAreaSelect({ selectionOpacity: 0.2, x1:s_x, y1: s_y, x2: s_x + s_max, y2: s_y + s_max, resizable: true, aspectRatio: '1:1', handles: true, persistent:true, minHeight: '50', minWidth: '50', maxHeight: '580', maxWidth: '580', onSelectChange: selectChange });
                } else {
                    $('img#album_cover').attr('src', base_url + '/media/photos/tmb/' + photo_nr + '.jpg');                                
                }
            }, "json");
    });                
}); 

                     
