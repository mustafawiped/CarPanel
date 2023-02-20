local db = dbConnect("sqlite","files/datas.db")

function getHandling(veh)
	return toJSON(getVehicleHandling(veh)) or {}
end

function getUpgrades(veh)
	local table = {}
	if isElement(veh) then
		local upgrades = getVehicleUpgrades(veh)
		for i, v in ipairs(upgrades) do
			table[i] = v
		end
		return toJSON(table)
	end
end

local dataNames = {
	["WheelsWidthF"] 	= true,
	["WheelsWidthR"] 	= true,
	["WheelsAngleF"] 	= true,
	["WheelsAngleR"] 	= true,
	["Wheels"] 			= true,
	["WheelsF"] 		= true,
	["WheelsR"] 		= true,
	["WheelsSize"] 		= true,
}

addEvent("MG-CarPanel:AraclariListele",true)
addEventHandler("MG-CarPanel:AraclariListele",getRootElement(),function()
    local hesap = getAccountName(getPlayerAccount(source))
    local veriler = dbPoll(dbQuery(db,"SELECT * FROM araclar WHERE sahip = ?",hesap),-1)
    triggerClientEvent(source,"MG-CarPanel:TekrarClienteGonder",source,veriler)
end)

addEvent("MG-CarPanel:AraciSatinAl1",true)
addEventHandler("MG-CarPanel:AraciSatinAl1",getRootElement(),function(aracid,fiyati)
    local parasi = getPlayerMoney(source)
    if parasi >= tonumber(fiyati) then
        if getPedOccupiedVehicle(source) and getPedOccupiedVehicleSeat(source) == 0 then
            takePlayerMoney(source,tonumber(fiyati))
            local hesap = getAccountName(getPlayerAccount(source))
            local arac = getPedOccupiedVehicle(source) or source
            local x,y,z = getElementPosition(arac)
            local liste = { x,y,z }
            local konum = toJSON(liste)
            local r1, g1, b1, r2, g2, b2 = getVehicleColor(arac, true)
			local renk = r1..","..g1..","..b1..","..r2..","..g2..","..b2
            local hp = getElementHealth(arac)
            local hand = getHandling(arac)
            local parcalar = getUpgrades(arac)
            local kambers = {}
            for isim,v in pairs(dataNames) do
                local veri = getElementData(arac,isim)
                kambers[isim] = veri
            end
            kamber = toJSON(kambers)
            km = "0"
            local time = getRealTime()
            local tarih = string.format("%02d-%02d-%04d", time.monthday, time.month + 1, time.year + 1900)
            dbExec(db,"INSERT INTO araclar (sahip,aracid,xyz,renk,hp,hand,parcalar,kamber,km,kaskodurum,kaskotarihi,araconcekisahibi,aracteslimtarihi,aracdurumu,aracsatisfiyat) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",hesap,aracid,konum,renk,hp,hand,parcalar,kamber,km,"Yok","Yok","Madde Gaming",tarih,"Sıfır",fiyati)
            destroyElement(arac)
            exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFBaşarıyla Araç Satın Aldın! F4 'den indirebilirsin.",source,255,255,255,true)
        else    
            exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFAraç Satın almak için, bir aracın şoför koltuğunda olmalısın.",source,255,255,255,true)
        end
    else
        exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFAracı Satın almak için yeterli paran yok.",source,255,255,255,true)
    end
end)