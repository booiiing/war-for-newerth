/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

function renderTerritories(canvas, territories) {
    if(!canvas.getContext){
        alert("Error: You need a Canvas compatible browser");
        return;
    }

    context = canvas.getContext('2d');
    w = canvas.width;
    h = canvas.height;
    context.clearRect( 0, 0, w, h );

    var vertices=[new Vertex(canvas.width/2, -canvas.height),
                  new Vertex(-canvas.width, canvas.height * 2),
                  new Vertex(canvas.width*2, canvas.height * 2)];
//    var vertices=[];
    for( var terr = 0; terr < territories.length; terr++ )
    {
        if(territories[terr]){
            var vertex = territories[terr];
            vertices.push(vertex)

            context.beginPath();
            context.arc( vertex.x, vertex.y, 5, 0, Math.PI*2, true );
            context.closePath();

            context.fillStyle = "#0000ff";
            context.fill();
        }
    }

    var triangles = [];
    
    try {
        triangles = Triangulate( vertices );
    } catch (e) { console.debug(e);return; }

    for(var i= 0; i < triangles.length; i++ )
    {
        var triangle = triangles[i];

        if (triangle) {

          context.beginPath();
          context.moveTo( triangle.v0.x, triangle.v0.y );
          context.lineTo( triangle.v1.x, triangle.v1.y );
          context.lineTo( triangle.v2.x, triangle.v2.y );
          context.closePath();
          context.strokeStyle= "#ff0000";
          context.stroke();



          context.beginPath();
          context.arc( triangle.center.x, triangle.center.y, triangle.radius, 0, Math.PI*2, true );
          context.closePath();
          context.strokeStyle= "#808080";
          context.stroke();



          vs = [triangle.v0, triangle.v1, triangle.v2];
          p = [triangle.center.x, triangle.center.y];
          // Find the triangles that share 2 vertices and join their circumcentres
          for(var t = 0; t < triangles.length; t++) {
            tr = triangles[t];
                if(tr && (containsVertex(vs, tr.v0) + containsVertex(vs, tr.v1) + containsVertex(vs, tr.v2)) == 2) {
                    context.beginPath();
                    context.moveTo( p[0], p[1] );
                    context.lineTo( tr.center.x, tr.center.y );
                    context.strokeStyle= "#00ff00";
                    context.stroke();
                }
            }
        }
    }

    for(var area_vertex = 0; area_vertex < vertices.length; area_vertex++ ) {
      var vertex = vertices[area_vertex];
      var path = getVoronoiPath(vertex, triangles);
      context.beginPath();
      context.fillStyle = "rgba("+parseInt(Math.random() * 256)+", "+parseInt(Math.random() * 256)+", "+parseInt(Math.random() * 256)+", 0.5)";
      for(var p=0; p < path.length; p++) {
        if (p == 0) {
          context.moveTo(path[p][0], path[p][1]);
        } else {
          context.lineTo(path[p][0], path[p][1]);
        }
      }
      context.closePath();
      context.fill();
    }
    
}