;-----------------------------------------------------
;Version: v1.0
;Date: 2021-12-02
;Author: szg
;Description: 首次安装软件后User Preferences当中一些个性化功能env变量的设置,写入env文件中
;         设置勾选：axlSetVariableFile  取消勾选，清除设置：axlUnsetVariableFile 
;Initial Release
;-----------------------------------------------------
axlCmdRegister("upvs" 'usr_preferences_variable_set ?cmdType "general")
axlCmdRegister("drr" 'D_Refdes_Rats ?cmdType "general")
procedure(usr_preferences_variable_set()
    let(()
    axlSetVariableFile("allegro_dynam_timing" "on") ;开启等长绕线的红绿灯提示
    axlSetVariableFile("allegro_dynam_timing_fixedpos" t) ;固定红绿灯提示的位置
    axlSetVariableFile("allegro_etch_length_on" t) ;开启走线时的走线长度提示框
    axlSetVariableFile("allegro_new_accuracy" "2") ;设置建立新设计文件时的单位精度为2
    axlSetVariableFile("allegro_new_units" "mils") ;设置建立新设计文件时的初始单位为mils
    axlSetVariableFile("nolast_file" t) ;取消建立新文件时打开上一次文件的记忆功能
    axlSetVariableFile("pcb_cursor" "infinite") ;设置鼠标显示方式
    axlSetVariableFile("recentfilelist" "5") ;设置file_recent designs里显示的历史纪录数量
    axlSetVariableFile("showmeasure_altunits" "millimeters") ;设置show element的双单位显示，辅单位为millimeters
    axlSetVariableFile("autosave" t) ;使能自动保存
    axlSetVariableFile("autosave_time" "10") ;自动保存时间10min
    axlSetVariableFile("ads_sdart" "GBR") ;GERBER文件的输出目录设置
    axlSetVariableFile("ads_sdlog" "LOG") ;LOG文件的输出目录设置
    axlSetVariableFile("infinite_cursor_bug_nt" t) ;减轻低配置机器及系统兼容性等问题可能存在的鼠标拖影
    axlSetVariableFile("disable_opengl_cache" t) ;减轻低配置机器的GPU负担

    axlUnsetVariableFile("shape_rki_autoclip") ;禁止大框铺铜时route keepin的限定裁剪，保留原shape外框
    axlUnsetVariableFile("logic_edit_enabled") ;禁止在PCB上自行增加器件、网络的功能
    axlUnsetVariableFile("acon_no_width_override_retain") ;走线线宽记忆功能，nil记忆上一次线宽

    axlVisibleUpdate(t)
    )
)
procedure(D_Refdes_Rats()
    let(()
    if(axlGetVariable("display_refdes_rats")
        then
            axlUnsetVariable("display_refdes_rats")
    else
        axlSetVariable("display_refdes_rats" t)
    )
    )
)