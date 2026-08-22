var doc = app.activeDocument;
for (var i = 0; i < doc.layers.length; i++) {
    var layer = doc.layers[i];
    doc.activeLayer = layer;
    try {
        executeAction(stringIDToTypeID("newPlacedLayer"), undefined, DialogModes.NO);
    } catch (e) {}
}