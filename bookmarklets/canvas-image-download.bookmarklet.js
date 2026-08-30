// @title Canvas Image: Download
;(function canvasImageDownload() {
	'use strict'

	const c = document.querySelector('canvas')

	if (!c) return alert('There is no canvas on this page.')

	c.toBlob(b => {
		const a = document.createElement('a')

		a.href = URL.createObjectURL(b)
		a.download = 'canvas.png'

		document.body.appendChild(a)

		a.click()
		a.remove()

		setTimeout(() => URL.revokeObjectURL(a.href), 1000)
	}, 'image/png')
})()
