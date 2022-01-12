;-------------------------------------------------------------------------------------
;Version: v1.0
;Date: 2021-08-22
;Author: szg
;Description: 设计规则的初始化
;Initial Release
;-------------------------------------------------------------------------------------
axlCmdRegister("rule_init" 'RuleInit ?cmdType "general")
procedure(RuleInit()
	let((ll_constraintValues accuraccy unit (coef 1) layer)
	;获取当前设计文件的单位和精度
	unit = car(axlDBGetDesignUnits())
	accuraccy = nth(1 axlDBGetDesignUnits())
	layer = axlGetParam("paramLayerGroup:Etch")->nChildren
	case(unit
	("millimeters" coef = 0.0254)
	("microns" coef = 25.4)
	("centimeters" coef = 0.00254)
	("inches" coef = 0.001)
	)
	;需设置的间距规则，mil为基准
	ll_table = makeTable("table" 0)
	ll_table['line_line] = fixnum(5*coef accuraccy)
	ll_table['line_shape] = fixnum(6*coef accuraccy)
	ll_table['thrupin_line] = fixnum(8*coef accuraccy)
	ll_table['thrupin_shape] = fixnum(8*coef accuraccy)
	ll_table['smdpin_line] = fixnum(6*coef accuraccy)
	ll_table['smdpin_shape] = fixnum(6*coef accuraccy)
	ll_table['smdpin_via] = fixnum(6*coef accuraccy)
	ll_table['via_via] = fixnum(8*coef accuraccy)
	ll_table['via_shape] = fixnum(6*coef accuraccy)
	ll_table['via_line] = fixnum(6*coef accuraccy)
	ll_table['thrupin_via] = fixnum(8*coef accuraccy)
	ll_table['thrupin_smdpin] = fixnum(8*coef accuraccy)
	ll_table['shape_shape] = fixnum(20*coef accuraccy)
	ll_constraintValues = tableToList(ll_table)
	;清理所有无用规则
	axlCnsPurgeAll()
	;默认的线宽规则5mil
	axlCNSSetPhysical("" nil 'width_min fixnum(5*coef accuraccy))
	;使能线宽规则的检查
	axlCNSPhysicalModeSet('all 'on)
	;以上间距规则设定
	axlCNSSetSpacing("" nil ll_constraintValues nil)
	if(layer > 2
		then
			axlCNSSetSpacing("" "TOP" 'shape_shape 6)
			axlCNSSetSpacing("" "Bottom" 'shape_shape 6)
	)
	;使能Spacing规则的检查
	axlCNSSpacingModeSet('all 'on)
	;使能Via的Z Axis Delay
	axlCNSSetViaZEnabled(t)
	;使能芯片内部Pin Delay
	axlCNSSetPinDelayEnabled(t)
	;清理文件数据库中的无用残留焊盘数据
	axlPurgePadstacks('padstacks nil)
	axlPurgePadstacks('via t)
	;使能同网络的DRC检查显示
	axlCNSSetSameNet(nil nil 'same_net t)
	;axlCNSGetSameNet("" "TOP" 'same_net) 
	)
)
;截取对应精度的浮点数
procedure(fixnum(num,accuraccy)
	let(()
	atof(sprintf(s strcat("%." sprintf(s "%n" accuraccy) "n") num))
	)
)