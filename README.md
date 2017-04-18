#专利代码

	void QgsMapToolNavigationJunction::canvasPressEvent(QgsMapMouseEvent* e)
	{
	  mPressPosition = e->pos();
	}

#专利代码

	void QgsMapToolNavigationJunction::canvasMoveEvent(QgsMapMouseEvent* e)
	{
	  QPoint currentCanvasPos = e->pos();
	  
	  QgsPolyline lineCircle = _getCircleLinearString(mPressPosition, currentCanvasPos);
	  QgsGeometry circle = QgsGeometry::fromPolyline(lineCircle);
	  mCircleRubberBand = new QgsGeometryRubberBand(mCanvas, circle.type());
	  QSettings setting;
	  QColor clr(
		setting.value("/qgis/digitizing/fill_color_red", 255).toInt(),
		setting.value("/qgis/digitizing/fill_color_green", 0).toInt(),
		setting.value("/qgis/digitizing/fill_color_bule", 0).toInt() );
	  double dbAlpha = setting.value("/qgis/digitizing/fill_color_alpha", 30).toInt()/ 255.0;
	  clr.setAlphaF(dbAlpha);
	  mCircleRubberBand->setFillColor(clr);
	  mCircleRubberBand->setOutlineWidth( setting.value( "/qgis/digitizing/line_width", 1 ).toInt() );
	  QgsAbstractGeometryV2* rbGeom = circle.geometry()->clone();
	  QgsVectorLayer* vLayer = qobject_cast<QgsVectorLayer*>( mCanvas->currentLayer() );
	  if( mCanvas->mapSettings().layerTransform(vLayer) )
	  {
		rbGeom->transform( *mCanvas->mapSettings().layerTransform(vLayer) );
	  }
	  mCircleRubberBand->setGeometry(rbGeom);
	}
	
#专利代码

	void QgsMapToolNavigationJunction::canvasReleaseEvent(QgsMapMouseEvent* e)
	{
	  QPoint currentCanvasPos = e->pos();
	  
	  QList<QgsSnappingResult> snapResults;
	  QgsPoint layerReleaseCoordPoint = toLayerCoordinates( mLayer, e->pos() );
	  QgsPoint mapReleasPoint = toMapCoordinates(mLayer, layerReleaseCoordPoint);

	  QgsPoint layerPressCoordPoint = toLayerCoordinates( mLayer, mPressPosition );
	  
	  double dbRadius = layerPressCoordPoint.distance(mapReleasPoint);

	  mSnapper.snapToCurrentLayer(e->pos(), snapResults, QgsSnapper::SnapToVertex, dbRadius);

	  _removeNotEndpoint(snapResults);
	  if(snapResults.size() < 2)
		return ;

	  _linkEndpointToPressPoint(snapResults, layerPressCoordPoint);
	}

	void QgsMapToolNavigationJunction::_linkEndpointToPressPoint(const QList<QgsSnappingResult>& snapResults, 
	const QgsPoint& layerPressCoordPoint)
	{
	  QList<QgsSnappingResult>::Iterator it = snapResults.begin();
	  for(; it != snapResults.end(); ++it)
	  {
		QgsFeature feature = _getFeature(*it);
		QgsPolyline line = feature.geometry()->asPolyline();
		
		if( 0 == (*it).snappedVertexNr )
		{
		  line.insert(0, layerPressCoordPoint);
		}
		else if( (line.size() - 1) == (*it).snappedVertexNr)
		{
		  line.append(layerPressCoordPoint);
		}
		
		mModifyFeatures.append( QPair<QgsFeature, QgsGeometry*>(feature, QgsGeometry::fromPolyline(line) ) );
	  } 
	}
