;-----------------------------------------------------
;Version: v1.0
;Date: 2021-12-05
;Author: szg
;Description: 单层及多层显示 L+num
;Initial Release
;-----------------------------------------------------
axlCmdRegister("L" 'Etch_LayerView ?cmdType "general")
procedure(Etch_LayerView(layer)
	let((len subetch)
	len = strlen(layer)
	subetch = axlGetParam("paramLayerGroup:Etch")->groupMembers
	axlVisibleDesign(nil)
	for(i 1 len
		n = substring(layer i 1)
		if(n=="0"
			then z = "Bottom"
		else 
			z = nthelem(atoi(n) subetch)
		)
		if(z == "Top"||"Bottom"
			then	
				axlVisibleLayer(strcat("Board Geometry/Soldermask_" z) t)
				axlVisibleLayer(strcat("Package Geometry/Soldermask_" z) t)
				axlVisibleLayer(strcat("Package Geometry/Pastemask_" z) t)
				axlVisibleLayer(strcat("Package Geometry/Display_" z) t)
				axlVisibleLayer(strcat("Package Geometry/Silkscreen_" z) t)
				axlVisibleLayer(strcat("Pin/Soldermask_" z) t)
				axlVisibleLayer(strcat("Pin/Pastemask_" z) t)
				axlVisibleLayer(strcat("Via Class/Soldermask_" z) t)
				axlVisibleLayer(strcat("Via Class/Pastemask_" z) t)
		)
		axlVisibleLayer("Board Geometry/Outline" t)
		axlVisibleLayer("Board Geometry/Cutout" t)
		axlVisibleLayer("Board Geometry/Design_Outline" t)
		axlVisibleLayer(strcat("Constraint Region/" z) t)
		axlVisibleLayer("Constraint Region/All" t)
		axlVisibleLayer(strcat("Drc Error Class/" z) t)
		axlVisibleLayer(strcat("Etch/" z) t)
		axlVisibleLayer(strcat("Pin/" z) t)
		axlVisibleLayer(strcat("Route Keepout/" z) t)
		axlVisibleLayer("Route Keepout/All" t)
		axlVisibleLayer(strcat("Via Class/" z) t)
	)
	axlVisibleUpdate(t)
	)
)