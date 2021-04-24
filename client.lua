local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local PlayerData = nil
ESX = nil
Citizen.CreateThread(function()
  while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
  end
  while PlayerData == nil do 
    PlayerData = ESX.GetPlayerData()
  end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)


RegisterNetEvent("crp_personal:mostar")
AddEventHandler("crp_personal:mostar", function()
  OpenMenuPersonal()
end)

function OpenLicensesInformation()
  ESX.UI.Menu.Close()

  ESX.UI.Menu.Open('default',GetCurrentResourceName(),'more_info',
  { 
  title = _U('titleInfo'), 
  align = 'bottom-right', 
  elements = {
      {label = _U('seedriver'), value = 'seeDriver'},
      {label = _U('showdriver'), value = 'showDriver'},
      {label = _U('seeguns'), value = 'seeGuns'},
      {label = _U('showguns'), value = 'showGuns'},
    },
  }, function(data, menu)

    local player, distance = ESX.Game.GetClosestPlayer()
    
      if data.current.value == 'seeDriver' then
        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')  
      elseif data.current.value == 'showDriver' then
        if distance ~= -1 and distance <= 3.0 then
          TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')   
        else
          ESX.ShowNotification('No hay jugadores <span style="color:yellow">cerca</span>') 
        end
      elseif data.current.value == 'seeGuns' then
        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')  
      elseif data.current.value == 'showGuns' then
        if distance ~= -1 and distance <= 3.0 then
          TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'weapon')  
        else
          ESX.ShowNotification('No hay jugadores <span style="color:yellow">cerca</span>')
        end
      end
    end, function(data, menu) 
  menu.close() 
  end)
end

function OpenHUDMenu()
  ESX.UI.Menu.Close()

  local hud = true
  local cinematica = false
  ESX.UI.Menu.Open('default',GetCurrentResourceName(),'hud_menu',
  { 
  title = _U('hudtitle'), 
  align = 'bottom-right', 
  elements = {
    -- {label = _U('toggleHUD'), value = 'togglehud'},
    {label = _U('cinematic'), value = 'cinematica'},
    -- {label = _U('clearChat'), value = 'clearChat'},
  },
    }, function(data, menu)
      if data.current.value == 'togglehud' then
        if hud then
          ExecuteCommand(Config.ComHud)
          ESX.ShowNotification('Has <span style="color:yellow">desactivado</span> el HUD') 
          hud = false
        else
          ExecuteCommand(Config.ComHud)                    
          ESX.ShowNotification('Has <span style="color:yellow">activado</span> el HUD') 
          hud = true 
        end
      elseif data.current.value == 'cinematica' then
        if cinematica then 
          ExecuteCommand(Config.Cine)                                                          
          ESX.ShowNotification('Has <span style="color:yellow">desactivado</span> el modo cinemática') 
          cinematica = false
        else
          ExecuteCommand(Config.Cine)                                                              
          ESX.ShowNotification('Has <span style="color:yellow">activado</span> el modo cinemática') 
          cinematica = true
        end
      elseif data.current.value == 'clearChat' then
        ExecuteCommand(Config.Clear)
        ESX.ShowNotification(Config.ClearNoti) 
      end
    end, function(data, menu) 
  menu.close() 
  end)
end

function OpenMenuPersonal()
  ESX.UI.Menu.CloseAll()

  local ids = true
  local job = PlayerData.job.label
  local jobgrade = PlayerData.job.grade_label

  --[[ EJEMPLO 
  
        {label = 'test', value = 'test_interaction'},

        Label = How is it going to look on the menu
        Value = "Identifier" for when you press

        ---------- Use value ----------

        if data.current.value == 'test_interaction' then

          print("Hellow")
          --Your code here
        end
        
        Cuando alguien presiona 'test', va a imprimir hola
  ]]--

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'menu_personal',
    {
      title    = _U('title'),
      align    = 'bottom-right',
      elements = {
        {label = _U('headerJob'), value = 'header'},
        {label = job .. " - " .. jobgrade, value = 'job_interaction'},
        {label = _U('headerGeneral'), value = 'header'},
        {label = _U('infoGraphics'), value = 'hud_interaction'},
        {label = _U('infoIds'), value = 'infoids'},
        {label = _U('headerPy'), value = 'header'},
        {label = 'Robar', value = 'robar'},
        {label = _U('stadistics'), value = 'stadistics'},
        {label = 'Animaciones', value = 'animaciones'},
        {label = _U('billing'), value = 'billing_menu'},
        {label = _U('headerLicenses'), value = 'header'},
        {label = _U('showid'), value = 'showid'},
        {label = _U('seeid'), value = 'seeid'},
        {label = _U('infoLicenses'), value = 'licenses_interaction'},
      },
    },
    function(data, menu)

      local player, distance = ESX.Game.GetClosestPlayer()

      if data.current.value == 'hud_interaction' then
        OpenHUDMenu()
      elseif data.current.value == 'robar' then
        ExecuteCommand(Config.Robar)                                                                                                
      elseif data.current.value == 'infoids' then
        if ids then
          ExecuteCommand(Config.NoID)                                           
         ESX.ShowNotification('Has <span style="color:yellow">ID Desactivadas</span>') 
         ids = false
        else
          ExecuteCommand(Config.SiID)                                                 
          ESX.ShowNotification('Has <span style="color:yellow">ID Activadas</span>') 
          ids = true 
        end
      elseif data.current.value == 'showid' then
        local player, distance = ESX.Game.GetClosestPlayer()
        if distance ~= -1 and distance <= 3.0 then
          TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))  
        else
        ESX.ShowNotification('No hay jugadores <span style="color:yellow">cerca</span>') 
        end
      elseif data.current.value == 'seeid' then
        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))   
      elseif data.current.value == 'licenses_interaction' then
        OpenLicensesInformation()
      elseif data.current.value == 'billing_menu' then
        ShowBillsMenu()                                
      elseif data.current.value == 'stadistics' then
        ExecuteCommand(Config.Stats)   
      elseif data.current.value == 'animaciones' then
        TriggerEvent(Config.Animations)
      end
    end,
    function(data, menu)
      menu.close()
    end
  )
end

function ShowBillsMenu()

ESX.TriggerServerCallback('esx_billing:getBills', function(bills)
  ESX.UI.Menu.CloseAll()
  local elements = {}

  for i=1, #bills, 1 do
    table.insert(elements, {
      label  = ('%s - <span style="color:red;">%s</span>'):format(bills[i].label, _U('invoices_item', ESX.Math.GroupDigits(bills[i].amount))),
      billID = bills[i].id
    })
  end

  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing',
  {
    title    = _U('invoices'),
    align    = 'bottom-right',
    elements = elements
  }, function(data, menu)
    menu.close()

    ESX.TriggerServerCallback('esx_billing:payBill', function()
      ShowBillsMenu()
    end, data.current.billID)
  end, function(data, menu)
    menu.close()
  end)
end)

end

RegisterCommand(Config.ComandoAbrir, function(source, args, rawCommand)
  OpenMenuPersonal()
end, false)



-- CAMBIA F10 a la tecla de preferencia
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if Config.TeclaC == true then 
      if IsControlJustReleased(0, Config.Tecla) and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'menu_personal')  then
        OpenMenuPersonal()
      end
    end
  end
end)