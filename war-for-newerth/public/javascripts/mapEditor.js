/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

var triangle_cache=[];
var bg = new Image();
bg.src = '../images/map.jpg';
var ping = new Image();
ping.src = '../images/ping.png';
var terr_img = new Image();
terr_img.src = '../images/plus_up.png';
var terr_selected_img = new Image();
terr_selected_img.src = '../images/plus_over.png';


function renderTerritories(canvas, territories) {
    if(!canvas.getContext){
        alert("Error: You need a Canvas compatible browser");
        return;
    }

    context = canvas.getContext('2d');
    w = canvas.width;
    h = canvas.height;
//    context.clearRect( 0, 0, w, h );
    context.drawImage(bg, 0, 0, w, h );

    var vertices=[new Vertex(canvas.width / 2, -canvas.height * 2),
                  new Vertex(-canvas.width, canvas.height * 3),
                  new Vertex(canvas.width * 3, canvas.height * 3)];
    var vertex_colors = [undefined, undefined, undefined];
    for( var terr = 0; terr < territories.length; terr++ )
    {
        if(territories[terr]){
            var vertex = territories[terr];
            vertices.push(vertex)


            if (current_territory && terr == current_territory) {
                vertex_colors.push([255, 255, 255]);
            } else if(territory_colors && territory_colors[terr]){
//                context.fillStyle = "rgb(" + territory_colors[terr][0] + "," +
//                                             territory_colors[terr][1] + "," +
//                                             territory_colors[terr][2] + ")";
                vertex_colors.push(territory_colors[terr]);
            } else {
//                context.fillStyle = "#FFFFFF"
                vertex_colors.push(undefined);
            }
//            context.beginPath();
//            context.arc( vertex.x, vertex.y, 5, 0, Math.PI*2, true );
//            context.closePath();
//            context.fill();
        }
    }

    try {
        triangle_cache = Triangulate( vertices );
    } catch (e) { console.debug(e);return; }

    context.strokeStyle= "#800000"
    for(var area_vertex = 0; area_vertex < vertices.length; area_vertex++ ) {
        if(vertex_colors[area_vertex]) {
            context.fillStyle = "rgba(" + vertex_colors[area_vertex][0] + "," +
                                         vertex_colors[area_vertex][1] + "," +
                                         vertex_colors[area_vertex][2] + ", 0.25)";
        } 
        var vertex = vertices[area_vertex];
        var path = getVoronoiPath(vertex, triangle_cache);
        context.beginPath();
        for(var p=0; p < path.length; p++) {
            if (p == 0) {
              context.moveTo(path[p][0], path[p][1]);
            } else {
              context.lineTo(path[p][0], path[p][1]);
            }
        }
        context.closePath();
        context.stroke();
        if(vertex_colors[area_vertex]) {
            context.fill();
        }

        
    }

    for( var terr = 0; terr < territories.length; terr++ ) {
        if(territories[terr]){
            var vertex = territories[terr];
            if (current_territory && terr == current_territory) {
                if (dragging) {
                    context.drawImage(ping,  vertex.x - ping.width/2, vertex.y - ping.height/2);
                } else {
                    context.drawImage(terr_selected_img,
                                      vertex.x - terr_selected_img.width/2, vertex.y - terr_selected_img.height/2);
                }
            } else {
                context.drawImage(terr_img,  vertex.x - terr_img.width/2, vertex.y - terr_img.height/2);
            }
        }
    }
    
//    for(var i= 0; i < triangles.length; i++ )
//    {
//        var triangle = triangles[i];
//
//        if (triangle) {
//
//          context.beginPath();
//          context.moveTo( triangle.v0.x, triangle.v0.y );
//          context.lineTo( triangle.v1.x, triangle.v1.y );
//          context.lineTo( triangle.v2.x, triangle.v2.y );
//          context.closePath();
//          context.strokeStyle= "#ff0000";
//          context.stroke();
//
//
//
//          context.beginPath();
//          context.arc( triangle.center.x, triangle.center.y, triangle.radius, 0, Math.PI*2, true );
//          context.closePath();
//          context.strokeStyle= "#808080";
//          context.stroke();
//
//
//
//          vs = [triangle.v0, triangle.v1, triangle.v2];
//          p = [triangle.center.x, triangle.center.y];
//          // Find the triangles that share 2 vertices and join their circumcentres
//          for(var t = 0; t < triangles.length; t++) {
//            tr = triangles[t];
//                if(tr && (containsVertex(vs, tr.v0) + containsVertex(vs, tr.v1) + containsVertex(vs, tr.v2)) == 2) {
//                    context.beginPath();
//                    context.moveTo( p[0], p[1] );
//                    context.lineTo( tr.center.x, tr.center.y );
//                    context.strokeStyle= "#00ff00";
//                    context.stroke();
//                }
//            }
//        }
//    }
}

function updatePaths(territories) {
    var html = "";
    for( var terr = 0; terr < territories.length; terr++ ) {
        if (territories[terr]){
            html += "<input id='territory_"+terr+"_shape' type='hidden' name='territory[shape]["+
                terr+"]' value='"+getVoronoiPath(territories[terr], triangle_cache)+"' />";
        }
    }
    $('territory_shapes').innerHTML=html;
}