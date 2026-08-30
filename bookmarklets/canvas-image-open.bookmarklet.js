// @title Canvas Image: Open
;(function canvasImageOpen() {
	'use strict'

	const c = document.querySelector('canvas')

	if (!c) return alert('There is no canvas on this page.')

	c.toBlob(b => window.open(URL.createObjectURL(b)), 'image/png')
})()
