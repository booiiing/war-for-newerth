/* 
 * Based on the Delaunay triangulation work of
 * Joshua Bell < inexorabletash@hotmail.com > for http://www.travellermap.com/
 *
 * @author flx <xf3l1x@gmail.com>
 * Finds the path of the bounding Voronoi area of a vertex given a triangulation.
 *
 */
function getVoronoiPath(vertex, triangles) {
  var n_tris = [];
  for(var t=0; t < triangles.length; t++) {
    var triangle = triangles[t];
    if (triangle) { 
        var vts = [triangle.v0, triangle.v1, triangle.v2];

        if( containsVertex(vts, vertex) ) {
          n_tris.push(triangle);
        }
    }
  }
  var path = [];
  if( n_tris.length > 2 ) {
    var t = n_tris.pop();
    while(n_tris.length){
      path.push([t.center.x, t.center.y]);
      var vs = [t.v0, t.v1, t.v2];
      var found = 0
      for(var tr = 0; tr < n_tris.length && !found; tr++ ){
	if((containsVertex(vs, n_tris[tr].v0) +
	    containsVertex(vs, n_tris[tr].v1) +
	    containsVertex(vs, n_tris[tr].v2)) == 2) {
	  t = n_tris.splice(tr, 1)[0];
	  found = 1;
	}
      }
      if(!found){return [];} // Non-closed area
    }
    path.push([t.center.x, t.center.y]);
  }

  return path;
}

function containsVertex(a, o) {
  for(var i = 0; i < a.length; i++) { if(a[i].x == o.x && a[i].y == o.y) { return 1; } }
  return 0;
}