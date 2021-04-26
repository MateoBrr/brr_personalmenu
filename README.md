
# BRR_PERSONALMENU [EN]

Features
- See your Job and grade
- HUD options
- Show / hide ID's
- Animations
- steal a person
- Stats (optional) if you have a stats menu you can change the command in config.lua file
- Bills
-  Documents

# BRR_PERSONALMENU [ES]

Caracteristicas 
- Ver trabajo y grado
- Opciones de HUD
- Ver/ocultar ID por comando
- Robar ejecuta un comando en el esx_thief /Robar
-  Estadisticas, Por si tienes un sistema de Estadisticas en el config,lua puedes poner el comando para abrir el menu
- Facturas y multas
- Animaciones 
- Documentos

# How to install

- add start brr_personalmenu in your cfg file 

- add this code on your esx_thief

``` lua
RegisterCommand('robar', function(source, args, rawCommand)
    if CheckIsPedDead() then
        ESX.ShowNotification("~r~La víctima está muerta")
    else
        robo()
    end
end, false) 
```


# DEPENDENCIES

- dpemotes : [https://github.com/andristum/dpemotes]
- jsfour-id card : [https://github.com/jonassvensson4/jsfour-idcard]
- esx_billing : [https://github.com/esx-framework/esx_billing]
- esx_thief : [https://github.com/esx-community/esx_thief]
