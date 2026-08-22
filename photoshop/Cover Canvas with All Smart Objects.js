var doc = app.activeDocument;

function isSmartObject(layer) {
    try {
        return layer.kind == LayerKind.SMARTOBJECT;
    } catch (e) {
        return false;
    }
}

function coverAndCenter(layer) {
    doc.activeLayer = layer;

    var bounds = layer.bounds;
    var layerW = bounds[2].as("px") - bounds[0].as("px");
    var layerH = bounds[3].as("px") - bounds[1].as("px");

    var docW = doc.width.as("px");
    var docH = doc.height.as("px");

    // scale factor to "cover"
    var scale = Math.max(docW / layerW, docH / layerH) * 100;

    layer.resize(scale, scale, AnchorPosition.MIDDLECENTER);

    // recalc bounds after resize
    bounds = layer.bounds;
    var newW = bounds[2].as("px") - bounds[0].as("px");
    var newH = bounds[3].as("px") - bounds[1].as("px");

    // center it
    var offsetX = (docW - newW) / 2 - bounds[0].as("px");
    var offsetY = (docH - newH) / 2 - bounds[1].as("px");

    layer.translate(offsetX, offsetY);
}

// loop through all layers (top-level only)
for (var i = 0; i < doc.layers.length; i++) {
    var layer = doc.layers[i];
    if (isSmartObject(layer)) {
        coverAndCenter(layer);
    }
}