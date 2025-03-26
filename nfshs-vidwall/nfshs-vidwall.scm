  (script-fu-register
            "script-fu-nfshs-vidwall"				;func name
            _"NFSHS Vidwall..."						;menu label
            "Styles an image in the style of Need for Speed High Stakes videowalls." ;description
            "AJ_Lethal"                             ;author
            "2022"        							;copyright notice
            "October 30, 2022"						;date created
            "RGB, RGBA" 							;image type that the script works on
		SF-IMAGE	"img"	0	;image variable, necessary
		SF-DRAWABLE	"draw" 0	;drawable variable, necessary
		SF-OPTION	"Hue/Saturation Preset"	'("None"
											"Aston Martin (125,50)"
											"BMW (225,25)"
											"Chevrolet (200,100)"
											"Ferrari/Pontiac (0,100)"
											"Ford (215,100)"
											"Holden/HSV (225,35)"
											"Jaguar (170,100)"
											"Lamborghini (42,100)"
											"McLaren (210,50)"
											"Mercedes (225,100)"
											"Porsche (40,90)"
											"Nissan (35,70)"
											)
		SF-LAYER	"Vidwall BG Layer"	0
		SF-ADJUSTMENT	"Background Hue" '(180 0 360 1 10 0 0)
		SF-ADJUSTMENT	"Background Saturation" '(50 0 100 1 10 0 0)
		SF-ADJUSTMENT	"Background Lightness" '(0 -100 100 1 10 0 0)
		SF-ADJUSTMENT	"Background Contrast" '(10 -127 127 1 10 0 0)
		SF-ADJUSTMENT	"Background Brightness" '(-10 -127 127 1 10 0 0)
		SF-ADJUSTMENT	"Blur Angle" '(0 0 360 1 10 0 0)
		SF-TOGGLE	"Generate vidwall with logo"	FALSE
		SF-ADJUSTMENT	"Logo Max Size" '(70 70 95 1 5 0 0)
		SF-TOGGLE	"Dark Logo"	FALSE
		SF-LAYER	"Vidwall Logo Layer"	-1
		SF-ADJUSTMENT	"Logo Hue" '(180 0 360 1 10 0 0)
		SF-ADJUSTMENT	"Logo Saturation" '(50 0 100 1 10 0 0)
		SF-ADJUSTMENT	"Logo Lightness" '(-10 -100 100 1 10 0 0)
		SF-OPTION	"Logo Blend Mode"	'("Normal"
										  "Dissolve"
										  "Behind"
										  "Multiply"
										  "Screen"
										  "Overlay"
										  "Difference"
										  "Addition"
										  "Subtract"
										  "Darken Only"
										  "Lighten Only"
										  "Hue"
										  "Saturation"
										  "Color"
										  "Value"
										  "Divide"
										  "Dodge"
										  "Burn"
										  "Hard Light"
										  "Soft Light"
										  "Grain Extract"
										  "Grain Merge"
										  "Color Erase"
										  "Erase Mode"
										  "Replace"
										  "Anti-Erase")
		SF-TOGGLE	"Copy generated vidwalls to new images"	FALSE
  )
  (script-fu-menu-register "script-fu-nfshs-vidwall" _"<Image>/Filters/Artistic")
  
  ;main variable definitions
  (define (script-fu-nfshs-vidwall
				img
				draw
				hueSatPreset
				bgLayer
				bgHue
				bgSaturation
				bgLightness
				bgContrast
				bgBrightness
				bgBlurAngle
				logoToggle
				logoMaxSize
				logoDarkToggle
				logoLayer
				logoHue
				logoSaturation
				logoLightness
				logoBlendMode
				exportToggle
				)
	;start of undo group
	(gimp-image-undo-group-start img)
    (gimp-context-push)
	
	;vidwall hue/saturation preset list
	(cond (
			(= 1  hueSatPreset)
				(begin
					(set! bgHue 125)
					(set! bgSaturation 50)
					(set! logoHue 150)
					(set! logoSaturation 50)
				)
			)
		(
			(= 2 hueSatPreset)
				(begin
					(set! bgHue 225)
					(set! bgSaturation 25)
					(set! logoHue 225)
					(set! logoSaturation 25)
				)
		)
		(
			(= 3  hueSatPreset)
					(begin
						(set! bgHue 200)
						(set! bgSaturation 100)
						(set! logoHue 215)
						(set! logoSaturation 50)
					)
		)
		(
			(= 4  hueSatPreset)
					(begin
						(set! bgHue 0)
						(set! bgSaturation 100)
						(set! logoHue 0)
						(set! logoSaturation 90)
					)
		)		
		(
			(= 5  hueSatPreset)
					(begin
						(set! bgHue 215)
						(set! bgSaturation 100)
						(set! logoHue 215)
						(set! logoSaturation 100)
					)
		)
		(
			(= 6  hueSatPreset)
				(begin
					(set! bgHue 225)
					(set! bgSaturation 35)
					(set! logoHue 205)
					(set! logoSaturation 60)
				)
		)
		(
			(= 7  hueSatPreset)
				(begin
					(set! bgHue 170)
					(set! bgSaturation 100)
					(set! logoHue 170)
					(set! logoSaturation 100)
				)
		)
		(
			(= 8  hueSatPreset)
				(begin
					(set! bgHue 42)
					(set! bgSaturation 100)
					(set! logoHue 45)
					(set! logoSaturation 25)
				)
		)
		(
			(= 9  hueSatPreset)
				(begin
					(set! bgHue 210)
					(set! bgSaturation 50)
					(set! logoHue 200)
					(set! logoSaturation 40)
				)
		)
		(
			(= 10  hueSatPreset)
				(begin
					(set! bgHue 225)
					(set! bgSaturation 100)
					(set! logoHue 230)
					(set! logoSaturation 45)
				)
		)
		(
			(= 11  hueSatPreset)
				(begin
					(set! bgHue 40)
					(set! bgSaturation 90)
					(set! logoHue 45)
					(set! logoSaturation 60)
				)
		)		
		(
			(= 12  hueSatPreset)
				(begin
					(set! bgHue 35)
					(set! bgSaturation 70)
					(set! logoHue 35)
					(set! logoSaturation 30)
				)
		)
	)
		;main function block
		(let*	( ;calculates image's dimensions
				(imgWidth
					(car
						(gimp-image-width img)
					)
				)
				(imgHeight 
					(car
						(gimp-image-height img)
					)
				)		
				)
			(let* ( ;creates new layer group for vidwall
					(vidwallLayerGroup
						(car 
							(gimp-layer-group-new img)
						)
					)
				)
				;adds the vidwall layer group and names it
				(gimp-image-insert-layer img vidwallLayerGroup 0 0)
				(gimp-item-set-name vidwallLayerGroup "tmpVidwall")
				(let* ( ;creates a copy the specified background for the vidwall
							(bgLayerCopy
									(car
										(gimp-layer-copy bgLayer FALSE)
									)
							)
						)
					;adds layer to vidwall layer group, gives it a temp name, applies effects to it and crops it to image's size
					(gimp-image-insert-layer img bgLayerCopy vidwallLayerGroup -1)
					(gimp-item-set-name bgLayerCopy "tmpVidwallBG")
					(gimp-colorize bgLayerCopy bgHue bgSaturation bgLightness)
					(gimp-brightness-contrast bgLayerCopy bgBrightness bgContrast)
					(plug-in-mblur 1 img bgLayerCopy 0 8 bgBlurAngle 0 0)
					(gimp-layer-resize-to-image-size bgLayerCopy)
				)
				;this block runs if the "Generate vidwall with logo" option is enabled
				(if (= TRUE logoToggle)
								(let* ( ;creates a copy the specified background for the logo
										(logoLayerCopy
											(car
												(gimp-layer-copy logoLayer FALSE)
											)
										)
										;calculates max dimensions allowed for logo (95% of image's width and 85% of it's height)
										(logoMaxWidth (* (car (gimp-image-width img)) (/ logoMaxSize 100)))
										(logoMaxHeight (* (car (gimp-image-height img)) (* (/ logoMaxSize 100) 0.90)))
										)
										;adds layer to vidwall layer group, gives it a temp name, applies effects to it, and crops it to content size
										(gimp-image-insert-layer img logoLayerCopy vidwallLayerGroup -1)
										(gimp-item-set-name logoLayerCopy "tmpVidwallLogo")
										(if (= FALSE logoDarkToggle)
											(gimp-colorize logoLayerCopy logoHue logoSaturation logoLightness)
											(let* (
													(logoLightnessDark (* logoLightness 0))
													(logoSaturationDark (/ logoSaturation 2))
												)
												(gimp-colorize logoLayerCopy logoHue logoSaturationDark logoLightnessDark)
											)	
										)
										(gimp-layer-set-mode logoLayerCopy logoBlendMode)
										(gimp-layer-set-opacity logoLayerCopy 90)
										(plug-in-autocrop-layer 1 img logoLayerCopy)
											;if the logo layer height exceeds the image's, resize it to max allowed height while keeping aspect ratio, with linear interpolation
											(if (< logoMaxHeight (car (gimp-drawable-height logoLayerCopy)))
												(let* (
													  (logoWidth (car (gimp-drawable-width logoLayerCopy)))
													  (logoHeight (car (gimp-drawable-height logoLayerCopy)))
													  (logoRatio (min (/ logoMaxWidth logoWidth) (/ logoMaxHeight logoHeight)))
													  (newLogoWidth (* logoRatio logoWidth))
													  (newLogoHeight (* logoRatio logoHeight))
													  )
												(gimp-context-set-interpolation 1)
												(gimp-layer-scale logoLayerCopy newLogoWidth newLogoHeight 1)
												)
											)
											;same as above but with the width
											(if (< logoMaxWidth (car (gimp-drawable-width logoLayerCopy)))
												(let* (
													  (logoWidth (car (gimp-drawable-width logoLayerCopy)))
													  (logoHeight (car (gimp-drawable-height logoLayerCopy)))
													  (logoRatio (min (/ logoMaxWidth logoWidth) (/ logoMaxHeight logoHeight)))
													  (newLogoWidth (* logoRatio logoWidth))
													  (newLogoHeight (* logoRatio logoHeight))
													  )
												(gimp-context-set-interpolation 1)
												(gimp-layer-scale logoLayerCopy newLogoWidth newLogoHeight 1)
												)
											)
										;centers the logo
										(let* (	(logoWidth (car (gimp-drawable-width logoLayerCopy)))
												(logoHeight (car (gimp-drawable-height logoLayerCopy)))
												(logoOffsetX (/ (- imgWidth logoWidth) 2))
												(logoOffsetY (/ (- imgHeight logoHeight) 2))
											)
											(gimp-layer-set-offsets logoLayerCopy logoOffsetX logoOffsetY)
										)
										(let*
											  ( ;creates new layer for the logo shadow
												(logoShadowLayer
														  (car
															  (gimp-layer-new
																img
																200
																100
																RGBA-IMAGE
																"tmpLogoShadow"
																95
																NORMAL-MODE
															  )
														  )
												)
											  )
												;adds shadow layer to vidwall layer group and applies the shadow
												(gimp-image-insert-layer img logoShadowLayer vidwallLayerGroup 1)
												(gimp-context-set-background '(0 0 0) )
												(gimp-layer-resize-to-image-size logoShadowLayer)
												(gimp-image-select-item img 2 logoLayerCopy)
												(gimp-selection-grow img 5)
												(gimp-edit-bucket-fill-full logoShadowLayer 1 0 100 255 FALSE TRUE 0 0 0)
												(gimp-selection-clear img)
												(plug-in-gauss 1 img logoShadowLayer 10 10 0)
												(gimp-image-select-item img 2 logoLayerCopy)
												(gimp-edit-clear logoShadowLayer)
												(gimp-selection-clear img)
												
												;this block runs if the "Dark logo" option is enabled
												(if (= TRUE logoDarkToggle)
													(let* ( ;finds the shadow layer by name and declares variable to colorize the inverted color shadow
															(logoShadowLayer (car (gimp-image-get-layer-by-name img "tmpLogoShadow")))
															(logoLightnessDark (* logoLightness -2))
															(logoSaturationDark (* logoSaturation 1.5))
														)
															;inverts shadow color and colorizes it
															(gimp-invert logoShadowLayer)
															(if (< 100 logoSaturationDark)
																(begin
																	(set! logoSaturationDark 100)
																)
															)
															(gimp-colorize logoShadowLayer logoHue logoSaturationDark logoLightnessDark)
													)
												)
										)
								)
				)
				(let*
				  ( ;creates new layer for the rounded black corners that will transparent in-game
					(frameLayer
							  (car
								  (gimp-layer-new
									img
									200
									100
									RGBA-IMAGE
									"tmpFrame"
									100
									NORMAL-MODE
								  )
							  )
					)
				  )
					;adds the frame layer to the vidwall layer group and draws the frame
					(gimp-image-insert-layer img frameLayer vidwallLayerGroup 0)
					(gimp-context-set-background '(0 0 0) )
					(gimp-layer-resize-to-image-size frameLayer)
					(gimp-image-select-round-rectangle img 2 0 0 imgWidth imgHeight 10 10)
					(gimp-selection-invert img)
					(gimp-edit-bucket-fill-full frameLayer 1 0 100 255 FALSE TRUE 0 0 0)
					(gimp-selection-clear img)
				)
				
				;this block runs if the "Copy generated vidwalls to new images" option is enabled but the "Generate vidwall with logo" one isn't
				(if (= TRUE exportToggle) (and (= FALSE logoToggle)
						(begin ;copies the vidwall layer group into a temp image, flattens it into a single layer and displayes the new image
							(gimp-edit-copy vidwallLayerGroup)
							(let* (	
									(vidwallPastedBuffer
											(car
												(gimp-edit-paste-as-new)
											)
									)
									(vidwallMergedBuffer
											(car
												(gimp-image-flatten vidwallPastedBuffer)
											)
									)											
								)
							(gimp-image-clean-all vidwallPastedBuffer)
							(gimp-display-new vidwallPastedBuffer)
							)
						)
					)
				)
				
				;same as the block above but with the "Generate vidwall with logo" option enabled
				(let* ( ;finds logo and shadow copies by name to declare their respective variables
						(logoShadowLayer (car (gimp-image-get-layer-by-name img "tmpLogoShadow")))
						(logoLayerCopy (car (gimp-image-get-layer-by-name img "tmpVidwallLogo")))
					)
					;copies, flattens the vidwall layer group to a new temp image like in the previous block but it hides the logo and shadow layers beforehand
					(if (= TRUE exportToggle) (and (= TRUE logoToggle)
							(begin
								(gimp-item-set-visible logoShadowLayer 0)
								(gimp-item-set-visible logoLayerCopy 0)
								(gimp-edit-copy vidwallLayerGroup)
								(let* (	
										(vidwallPastedBuffer
												(car
													(gimp-edit-paste-as-new)
												)
										)
										(vidwallMergedBuffer
												(car
													(gimp-image-flatten vidwallPastedBuffer)
												)
										)
											
									)
								(gimp-layer-set-name vidwallMergedBuffer "Vidwall")
								(gimp-image-clean-all vidwallPastedBuffer)
								(gimp-display-new vidwallPastedBuffer)
								)
								;shows the logo and shadow layers before repeating the above process to generate the 2nd vidwall
								(gimp-item-set-visible logoShadowLayer 1)
								(gimp-item-set-visible logoLayerCopy 1)
								(gimp-edit-copy vidwallLayerGroup)
								(let* (	
										(vidwallPastedBuffer2
												(car
													(gimp-edit-paste-as-new)
												)
										)
										(vidwallMergedBuffer2
												(car
													(gimp-image-flatten vidwallPastedBuffer2)
												)
										)										
									)
								(gimp-layer-set-name vidwallMergedBuffer2 "Vidwall w/ logo")
								(gimp-image-clean-all vidwallPastedBuffer2)
								(gimp-display-new vidwallPastedBuffer2)
								)
							)
						)
					)
				)
			;renames the temp layers to their final names
			(let* (	
					(bgLayerCopy (car (gimp-image-get-layer-by-name img "tmpVidwallBG")))
					(frameLayer (car (gimp-image-get-layer-by-name img "tmpFrame")))
				  )
				(gimp-layer-set-name vidwallLayerGroup "Vidwall")
				(gimp-layer-set-name bgLayerCopy "VidwallBG")
				(gimp-layer-set-name frameLayer "Frame")
				(if (= TRUE logoToggle)
						(let* (
								(logoLayerCopy (car (gimp-image-get-layer-by-name img "tmpVidwallLogo")))
								(logoShadowLayer (car (gimp-image-get-layer-by-name img "tmpLogoShadow")))
							)
						(gimp-layer-set-name logoLayerCopy "VidwallLogo")
						(gimp-layer-set-name logoShadowLayer "LogoShadow")
						)
				)
			)
		)
	)
	;end of undo group, discards tool settings used
	(gimp-context-pop)
    (gimp-image-undo-group-end img)
    (gimp-displays-flush)
	)