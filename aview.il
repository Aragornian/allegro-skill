;-----------------------------------------------------
;Version: v1.0
;Date: 2021-11-28
;Author: szg
;Description: 丝印层，装配层等的显示设置
;Initial Release
;-----------------------------------------------------
axlCmdRegister("s1" 'D_Silkscreen_Top ?cmdType "general")
axlCmdRegister("s2" 'D_Silkscreen_Bottom ?cmdType "general")
axlCmdRegister("a1" 'D_Assembly_Top ?cmdType "general")
axlCmdRegister("a2" 'D_Assembly_Bottom ?cmdType "general")
axlCmdRegister("r1" 'D_All_Layers ?cmdType "general")
axlCmdRegister("r2" 'D_Noall_Layers ?cmdType "general")
axlCmdRegister("des" 'Design_Extent_Set ?cmdType "general")
;TOP层丝印视图
procedure(D_Silkscreen_Top()
    let((layers)
    layers = list("Board Geometry/Outline" "Board Geometry/Design_Outline" "Board Geometry/Cutout" "Via Class/Soldermask_Top"  
    "Pin/Soldermask_Top" "Board Geometry/Soldermask_Top" "Board Geometry/Silkscreen_Top" "Package Geometry/Display_Top" 
    "Package Geometry/Silkscreen_Top" "Package Geometry/Soldermask_Top"  "Ref Des/Silkscreen_Top") ;需要显示的层
    View_Set(layers)
    )
)
;BOTTOM层丝印视图
procedure(D_Silkscreen_Bottom()
    let((layers)
    layers = list("Board Geometry/Outline" "Board Geometry/Design_Outline" "Board Geometry/Cutout" "Via Class/Soldermask_Bottom"  
    "Pin/Soldermask_Bottom" "Board Geometry/Soldermask_Bottom" "Board Geometry/Silkscreen_Bottom" "Package Geometry/Display_Bottom" 
    "Package Geometry/Silkscreen_Bottom" "Package Geometry/Soldermask_Bottom"  "Ref Des/Silkscreen_Bottom")
    View_Set(layers)
    )
)
;TOP层装配层视图
procedure(D_Assembly_Top()
    let((layers)
    layers = list("Board Geometry/Outline" "Board Geometry/Design_Outline" "Board Geometry/Cutout" "Package Geometry/Assembly_Top" 
    "Ref Des/Assembly_Top")
    View_Set(layers)
    )
)
;BOTTOM层装配层视图
procedure(D_Assembly_Bottom()
    let((layers)
    layers = list("Board Geometry/Outline" "Board Geometry/Design_Outline" "Board Geometry/Cutout" "Package Geometry/Assembly_Bottom" 
    "Ref Des/Assembly_Bottom")
    View_Set(layers)
    )
)
;显示所有的层
procedure(D_All_Layers()
    let(()
    axlVisibleDesign(t)
    axlVisibleUpdate(t)
    )
)
;关闭所有的层
procedure(D_Noall_Layers()
    let(()
    axlVisibleDesign(nil)
    axlVisibleUpdate(t)
    )
)
;显示函数
procedure(View_Set(layers)
    let(()
    axlVisibleDesign(nil)
    (foreach l layers
        axlVisibleLayer(l t)
    )
    axlVisibleUpdate(t)
    )
)
;设定设计范围
procedure(Design_Extent_Set(@optional (arg nil))
    let((unit (coef 1) extents)
    unit = car(axlDBGetDesignUnits())
	case(unit
	("millimeters" coef = 0.0254)
	("microns" coef = 25.4)
	("centimeters" coef = 0.00254)
	("inches" coef = 0.001)
	)
    while((!arg) arg = 1000)
    if(type(arg) == 'string
        then arg = atof(arg)
    )
    extents = axlExtentDB('obstacle)
    extents = bBoxAdd(extents list(list(-arg*coef -arg*coef) list(arg*coef arg*coef)))
    axlDBChangeDesignExtents(extents)
    )
)