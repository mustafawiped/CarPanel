local db = dbConnect("sqlite","files/datas.db")
local aracindirmesiniri = 5
local indirenler = { }
local indaraclar = { }
local araclar = { }
local satiliklar = { }
local uyarilar = { }
local kullanilanlar = { }
local takasistekleri = { }
local kabuledenler = { }
local kmler = { }

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

function setHandling(veh, data)
	local table = fromJSON(data) or {}
	if table and table ~= {} then
		for i, v in pairs(table) do
			setVehicleHandling(veh, i, v) 
		end
	end
end

function addUpgrades(veh, data)
	local upgrades = fromJSON(data or toJSON ( { } ))
	for i, v in ipairs(upgrades) do
		addVehicleUpgrade(veh, v)
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
			local _, _, rz = getElementRotation(arac)
            local liste = { x,y,z,rz }
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
            dbExec(db,"INSERT INTO araclar (sahip,aracid,xyz,renk,hp,hand,parcalar,kamber,km,kaskodurum,kaskotarihi,araconcekisahibi,aracteslimtarihi,aracdurumu,aracsatisfiyat,indirme,araconcekifiyat) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",hesap,aracid,konum,renk,hp,hand,parcalar,kamber,km,"Yok","Yok","Madde Gaming",tarih,"İkinci El",fiyati,"","")
            destroyElement(arac)
            exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFBaşarıyla Araç Satın Aldın! F4 'den indirebilirsin.",source,255,255,255,true)
        else    
            exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFAraç Satın almak için, bir aracın şoför koltuğunda olmalısın.",source,255,255,255,true)
        end
    else
        exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFAracı Satın almak için yeterli paran yok.",source,255,255,255,true)
    end
end)

addEvent("MG-CarPanel:AracIndir",true)
addEventHandler("MG-CarPanel:AracIndir",getRootElement(),function(id,fiyat,durum)
    local hesap = getAccountName(getPlayerAccount(source))
    local varmi = false
    for i=1,#indaraclar do
        if indaraclar[i] == id then
            exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFBu aracı zaten indirdin.",source,255,255,255,true)
            return
        end
    end
    local sayi = 0
    for i,v in pairs(indirenler) do
        if v[1] == hesap then
            sayi = v[2]
        end
    end
    if sayi >= aracindirmesiniri then
        exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFEn fazla"..aracindirmesiniri.." tane araç indirilebilir.",source,255,255,255,true) 
        return
    else
        if sayi == 0 then
            table.insert(indirenler,{hesap,1})
            sayi = sayi + 1
        else
            for i,v in pairs(indirenler) do
                if v[1] == hesap then
                    v[2] = v[2] + 1
                end
            end
        end
    end
    local xyz,renk,hp,hand,parcalar,kamber
    local hesap = getAccountName(getPlayerAccount(source))
    local data = dbPoll(dbQuery(db,"SELECT * FROM araclar WHERE id = ?",id),-1)
    local x,y,z,rz,_,_
    if durum == "satis" then
        x,y,z = getElementPosition(source)
        x = x - 3
        _,_,rz= getElementRotation(source)
    else
        local location = fromJSON(data[1]["xyz"])
        x,y,z,rz = unpack(location)
    end
    local arac = createVehicle(data[1]["aracid"],x,y,z,0,0,rz)
    local renk = split(data[1]["renk"], ',')
    local r1,g1,b1,r2,g2,b2 = renk[1],renk[2],renk[3],renk[4],renk[5],renk[6]
    setVehicleColor(arac, r1, g1, b1, r2, g2, b2)
    setElementHealth(arac,data[1]["hp"])
	setHandling(arac, data[1]["hand"])
    addUpgrades(arac,data[1]["parcalar"])
    local kamber = fromJSON(data[1]["kamber"] or toJSON({}) )
    for data,veri in pairs(kamber or {}) do
        setElementData(arac,data,veri)
    end
    if durum == "satis" then
        dbExec(db,"UPDATE araclar SET aracsatisfiyat = ? WHERE id = ?",fiyat,id)
        setElementAlpha(arac,200)
        setVehicleEngineState(arac,false)
        setElementFrozen(arac,true)
        setVehicleDamageProof(arac,true)
        kmalcazmi = true
        table.insert(satiliklar,{ arac,id,data[1]["aracid"],fiyat,source })
    end
    setElementData(arac,"MG-AracPanel-KM",data[1]["km"])
    setElementData(arac,"MG-AracPanel-Arac",true)
    setElementData(arac,"MG-AracPanel-Sahip",source)
    setElementData(arac,"MG-AracPanel-ID",id)
    if data[1]["kaskodurum"] == "Var" then
        setElementData(arac,"MG-AracKaskosu",true)
    end
    table.insert(indaraclar,id)
    table.insert(araclar,{id,arac})
    dbExec(db,"UPDATE araclar SET indirme = ? WHERE id = ?","indirildi",id)
    exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFAraç başarıyla indirildi.",source,255,255,255,true)
end)

addEventHandler("onPlayerQuit", root,function()
    for i, arac in ipairs (getElementsByType("vehicle")) do
        if getElementData(arac, "MG-AracPanel-Sahip") == source then
            local durm = false
                for ia,va in pairs(satiliklar) do
                    if tostring(va[2]) == tostring(arac) then
                        table.remove(satiliklar,ia)
                        durm = true
                    end
                end
            local x,y,z = getElementPosition(arac)
            local _,_,rz = getElementRotation(arac)
            local liste = { x,y,z,rz }
            local konum = toJSON(liste)
            local r1, g1, b1, r2, g2, b2 = getVehicleColor(arac, true)
			local renk = r1..","..g1..","..b1..","..r2..","..g2..","..b2
            local hp = getElementHealth(arac)
            local hand = getHandling(arac)
            local parcalar = getUpgrades(arac)
            local km = getElementData(arac,"MG-AracPanel-KM")
            local kambers = {}
            for isim,v in pairs(dataNames) do
                local veri = getElementData(arac,isim)
                kambers[isim] = veri
            end
            kamber = toJSON(kambers)
            local id = getElementData(arac,"MG-AracPanel-ID")
            local hesap = getAccountName(getPlayerAccount(source))
            for i,v in pairs(indirenler) do
                if v[1] == hesap then
                    if v[2] ~= 0 then
                        v[2] = v[2] - 1
                    end 
                end
            end
            for i=1,#indaraclar do
                if tostring(indaraclar[i]) == tostring(id) then
                    table.remove(indaraclar,i)
                end
            end
            for i,v in pairs(araclar) do
                if tostring(v[1]) == tostring(id) then
                    table.remove(araclar,i)
                end
            end
            if durm == false then
                dbExec(db,"UPDATE araclar SET xyz = ?, renk = ?, hp = ?, hand = ?, parcalar = ?, kamber = ?,indirme = ?,km = ? WHERE id = ?",konum,renk,hp,hand,parcalar,kamber,"",km,id)
            else
                dbExec(db,"UPDATE araclar SET renk = ?, hp = ?, hand = ?, parcalar = ?, kamber = ?,indirme = ?,km = ? WHERE id = ?",renk,hp,hand,parcalar,kamber,"",km,id)
            end
            destroyElement(arac)
        end
    end
end)

addEvent("MG-CarPanel:AracKaldir",true)
addEventHandler("MG-CarPanel:AracKaldir",getRootElement(),function(id)
    local data = dbPoll(dbQuery(db,"SELECT * FROM araclar WHERE id = ?",id),-1)
    if data[1]["indirme"] == "indirildi" then
        for i,v in pairs(araclar) do
            if tonumber(v[1]) == tonumber(id) then
                local durm = false
                for ia,va in pairs(satiliklar) do
                    if tostring(va[2]) == tostring(v[1]) then
                        table.remove(satiliklar,ia)
                        durm = true
                    end
                end
                local x,y,z = getElementPosition(v[2])
                local _,_,rz = getElementRotation(v[2])
                local liste = { x,y,z,rz }
                local konum = toJSON(liste)
                local r1, g1, b1, r2, g2, b2 = getVehicleColor(v[2], true)
                local renk = r1..","..g1..","..b1..","..r2..","..g2..","..b2
                local hp = getElementHealth(v[2])
                local hand = getHandling(v[2])
                local parcalar = getUpgrades(v[2])
                local kambers = {}
                local km = getElementData(v[2],"MG-AracPanel-KM")
                for isim,vu in pairs(dataNames) do
                    local veri = getElementData(v[2],isim)
                    kambers[isim] = veri
                end
                kamber = toJSON(kambers)
                local id = getElementData(v[2],"MG-AracPanel-ID")
                local hesap = getAccountName(getPlayerAccount(source))
                for ix,vx in pairs(indirenler) do
                    if vx[1] == hesap then
                        if vx[2] ~= 0 then
                            vx[2] = vx[2] - 1
                        end 
                    end
                end
                for ia=1,#indaraclar do
                    if tostring(indaraclar[ia]) == tostring(id) then
                        table.remove(indaraclar,ia)
                    end
                end
                table.remove(araclar,i)
                if durm == false then
                    dbExec(db,"UPDATE araclar SET xyz = ?, renk = ?, hp = ?, hand = ?, parcalar = ?, kamber = ?, indirme = ?,km = ? WHERE id = ?",konum,renk,hp,hand,parcalar,kamber,"",km,id)
                else
                    dbExec(db,"UPDATE araclar SET renk = ?, hp = ?, hand = ?, parcalar = ?, kamber = ?, indirme = ?,km = ? WHERE id = ?",renk,hp,hand,parcalar,kamber,"",km,id)
                end
                destroyElement(v[2])
                exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFAraç başarıyla kaldırıldı.",source,255,255,255,true)
            end
        end
    else
        exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFİndirilmemiş bir aracı kaldıramazsın.",source,255,255,255,true)
    end
end)

function aracSatinAl(oyuncu)
    local arac = getPedOccupiedVehicle(oyuncu)
    local id = getElementData(arac,"MG-AracPanel-ID")
    local veriler = dbPoll(dbQuery(db,"SELECT * FROM araclar WHERE id = ?",id),-1)
    triggerClientEvent(oyuncu,"MG-CarPanel:SatisBilgilendirme",oyuncu,veriler)
end

addEventHandler("onVehicleEnter",getRootElement(),function(pl)
    for i,v in pairs(satiliklar) do
        if v[1] == source then
            bindKey(pl,"M","down",aracSatinAl)
            exports.hud:drawNote("SatilikYazi", "#FFFFFFBu araç "..getPlayerName(v[5]).." #FFFFFFtarafından satılık. Satın almak için, #FF7F00M #FFFFFFtuşuna basınız. Fiyatı: #FF7F00$"..tonumber(v[4]), pl, 255,255,255)	
        end
    end
end)

addEventHandler("onVehicleExit",getRootElement(),function(pl)
    for i,v in pairs(satiliklar) do
        if v[1] == source then
            unbindKey(pl,"M","down",aracSatinAl)
            exports.hud:drawNote("SatilikYazi", "", pl, 255,255,255)
        end
    end
end)

addEventHandler("onVehicleExplode",getRootElement(),function()
    if getElementType(source) == "vehicle" and getElementData(source,"MG-AracPanel-Arac") == true then
        local oyuncu = getElementData(source,"MG-AracPanel-Sahip")
        local hesap = getAccountName(getPlayerAccount(oyuncu))
        local id = getElementData(source,"MG-AracPanel-ID")
        local km = getElementData(source,"MG-AracPanel-KM")
        for i,v in pairs(indirenler) do
            if v[1] == hesap then
                if v[2] ~= 0 then
                    v[2] = v[2] - 1
                end 
            end
        end
        for i=1,#indaraclar do
            if tostring(indaraclar[i]) == tostring(id) then
                table.remove(indaraclar,i)
            end
        end
        for i,v in pairs(araclar) do
            if tostring(v[1]) == tostring(id) then
                table.remove(araclar,i)
            end
        end
        dbExec(db,"UPDATE araclar SET indirme = ?,km = ? WHERE id = ?","",km,id)
    end
end)

addEvent("MG-CarPanel:AracBilgiSatis",true)
addEventHandler("MG-CarPanel:AracBilgiSatis",getRootElement(),function(id,dd)
    local veri = dbPoll(dbQuery(db,"SELECT * FROM araclar WHERE id = ?",id),-1)
    if dd == "bilgi" then
        triggerClientEvent(source,"MG-CarPanel:BilgiEkrani",source,veri)
    else

    end
end)

addEvent("MG-CarPanel:AracYaninaCek",true)
addEventHandler("MG-CarPanel:AracYaninaCek",getRootElement(),function(id)
    if getPlayerMoney(source) >= 1000 then
        local data = dbPoll(dbQuery(db,"SELECT * FROM araclar WHERE id = ?",id),-1)
        if data[1]["indirme"] == "indirildi" then
            for i,v in pairs(araclar) do
                if tostring(v[1]) == tostring(id) then
                    local x,y,z = getElementPosition(source)
                    setElementPosition(v[2],x,y,z)
                    warpPedIntoVehicle(source,v[2])
                    takePlayerMoney(source,1000)
                    exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFBaşarıyla aracı yanına çektin.",source,255,255,255,true)
                end
            end
        else
            exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFİndirilmemiş bir aracı yanına çekemezsin.",source,255,255,255,true)
        end
    else
        exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFAracı yanına çekmek için yeteri kadar paran yok.",source,255,255,255,true)
    end
end)

function ParaGonder(hesap,miktar)
    exports["bankasistem"]:AraziParasiniVer(miktar,hesap);
end

addEvent("MG-CarPanel:AraciSatinAl2",true)
addEventHandler("MG-CarPanel:AraciSatinAl2",getRootElement(),function(id)
    local data = dbPoll(dbQuery(db,"SELECT * FROM araclar WHERE id = ?",id),-1)
    local fiyati = tonumber(data[1]["aracsatisfiyat"])
    if getPlayerMoney(source) >= fiyati then
        local oncekisahip = tostring(data[1]["sahip"])
        local hesap = getAccountName(getPlayerAccount(source))
        if tostring(oncekisahip) == tostring(hesap) then exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFKendi aracını alamazsın.",source,255,255,255,true) return end
        takePlayerMoney(source,fiyati)  
        dbExec(db,"UPDATE araclar SET sahip = ?, araconcekisahibi = ?, araconcekifiyat = ?, indirme = ? WHERE id = ?",hesap,oncekisahip,fiyati,"",id)
        for i,v in pairs(indirenler) do
            if v[1] == oncekisahip then
                if v[2] ~= 0 then
                    v[2] = v[2] - 1
                end 
            end
        end
        for i=1,#indaraclar do
            if tostring(indaraclar[i]) == tostring(id) then
                table.remove(indaraclar,i)
            end
        end
        for i,v in pairs(araclar) do
            if tostring(v[1]) == tostring(id) then
                table.remove(araclar,i)
                for ia,va in pairs(satiliklar) do
                    if tostring(va[2]) == tostring(v[2]) then
                        table.remove(satiliklar,ia)
                    end
                end
                destroyElement(v[2])
            end
        end
        unbindKey(source,"M","down",aracSatinAl)
        ParaGonder(oncekisahip,fiyati)
        exports.hud:drawNote("SatilikYazi", "",source, 255,255,255)
        exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFBaşarıyla Aracı satın aldın! F4 'den aracını indirebilirsin.",source,255,255,255,true)
    else
        exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFAracı satın almak için yeteri kadar paran yok.",source,255,255,255,true)
    end
end)

addEvent("MG-CarPanel:SunucuyaSat",true)
addEventHandler("MG-CarPanel:SunucuyaSat",getRootElement(),function(id,fiyat)
    for i=1,#indaraclar do
        if indaraclar[i] == id then
            exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFSunucuya satmak için aracı kaldırmanız gerekiyor.",source,255,255,255,true)
            return
        end
    end
    local verilecek = tonumber(fiyat) / 2
    if verilecek > 1 then
        dbExec(db,"DELETE FROM araclar WHERE id = ?",id)
        givePlayerMoney(source,verilecek)
        exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFAracını Başarıyla Madde Gaming 'e "..verilecek.."$ 'a sattın!",source,255,255,255,true)
    else
        dbExec(db,"DELETE FROM araclar WHERE id = ?",id)
        exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFAracın değeri çok düşük olduğu için herhangi bir ödeme almadın.",source,255,255,255,true)
    end
end)

addEvent("MG-CarPanel:KaskoListele",true)
addEventHandler("MG-CarPanel:KaskoListele",getRootElement(),function()
    local hesap = getAccountName(getPlayerAccount(source))
    local data = dbPoll(dbQuery(db,"SELECT id,aracid, kaskodurum,kaskotarihi FROM araclar WHERE sahip = ?",hesap),-1)
    triggerClientEvent(source,"MG-CarPanel:TekrarClienteGonder2",source,data)
end)

function biraysonra(bugunGun,bugunAy,bugunYil)
    local gun,ay,yil
    if tostring(bugunAy) == "12" then
        gun = bugunGun
        ay = "1"
        yil = bugunYil + 1
    elseif tostring(bugunAy) == "1" then
        if tonumber(bugunGun) > 28 then
            local nb = tonumber(bugunGun) - 28
            gun = "0"..tostring(nb)
            ay = bugunAy + 2
            yil = bugunYil
        else
            gun = bugunGun
            ay = bugunAy + 1
            yil = bugunYil
        end
    elseif tostring(bugunAy) == "3" or tostring(bugunAy) == "5" or tostring(bugunAy) == "8" or tostring(bugunAy) == "10" then
        if tostring(bugunGun) == "31" then
            gun = "1"
            ay = bugunAy + 2
            yil = bugunYil
        else
            gun = bugunGun
            ay = bugunAy + 1
            yil = bugunYil
        end
    else
        gun = bugunGun
        ay = bugunAy + 1
        yil = bugunYil
    end
    return string.format("%02d-%02d-%04d", gun, ay, yil)
end

addEvent("MG-CarPanel:KaskoYaptirma",true)
addEventHandler("MG-CarPanel:KaskoYaptirma",getRootElement(),function(id,fiyat)
    if getPlayerMoney(source) >= tonumber(fiyat) then
        takePlayerMoney(source,tonumber(fiyat))
        local data = dbPoll(dbQuery(db,"SELECT * FROM araclar WHERE id = ?",id),-1)
        local time = getRealTime()
        local tarih = biraysonra(tonumber(time.monthday),tonumber(time.month+1),tonumber(time.year+1900))
        if data[1]["indirme"] == "indirildi" then
            for i,v in pairs(araclar) do
                if v[1] == id then
                    setElementData(v[2],"MG-AracKaskosu",true)
                    if getElementData(v[2],"MG-AracKaskosu") == true then
                    end
                    dbExec(db,"UPDATE araclar SET kaskodurum = ?, kaskotarihi = ? WHERE id = ?","Var",tarih,id)
                end
            end
        else
            dbExec(db,"UPDATE araclar SET kaskodurum = ?, kaskotarihi = ? WHERE id = ?","Var",tarih,id)
        end
        outputChatBox("#FF7F00[MG | Araç Sistemi] #FFFFFFBaşarıyla Araç Kaskosu yaptırdın!",source,255,255,255,true)
        outputChatBox("#FF7F00[MG | Araç Sistemi] #FFFFFFAylık Kasko Ödemesi: "..fiyat,source,255,255,255,true)
        outputChatBox("#FF7F00[MG | Araç Sistemi] #FFFFFFKasko Bitiş Tarihi: "..tarih,source,255,255,255,true)
    else
        exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFKasko yaptırmak için yeterli paran yok. Gereken Miktar: #FF7F00$"..fiyat,source,255,255,255,true)
    end
end)

addEvent("MG-CarPanel:KaskoYenileme",true)
addEventHandler("MG-CarPanel:KaskoYenileme",getRootElement(),function(id,fiyat,tarih)
    if getPlayerMoney(source) >= tonumber(fiyat) then
        local ay = string.sub(tarih,4,5)
        local time = getRealTime()
        if (tonumber(ay) - tonumber(time.month+1)) >= 3 then
            exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFEn fazla 3 ay uzatabilirsin. Bir daha yenilemek için, #ff7f00 1#ffffff Ay bekle.",source,255,255,255,true)
            return
        elseif (tonumber(ay) - tonumber(time.month+1)) < 0 then
            exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFKaskonu daha fazla uzatamazsın. Uzatmak için #ff7f00Kaskonun bitmesini#ffffff bekle.",source,255,255,255,true)
            return
        end
        local gun,ay2,yil
        if tostring(string.sub(tarih,1,1)) == "0" then
            gun = string.sub(tarih,2,2)
        else
            gun = string.sub(tarih,1,2)
        end
        if string.sub(tarih,4,4) == "0" then
            ay2 = string.sub(tarih,5,5)
        else
            ay2 = string.sub(tarih,4,5)
        end
        yil = string.sub(tarih,7,10)
        local yenitarih = biraysonra(tonumber(gun),tonumber(ay2),tonumber(yil))
        dbExec(db,"UPDATE araclar SET kaskotarihi = ? WHERE id = ?",yenitarih,id)
        outputChatBox("#FF7F00[MG | Araç Sistemi] #FFFFFFBaşarıyla Kasko Süresini Uzattın!",source,255,255,255,true)
        outputChatBox("#FF7F00[MG | Araç Sistemi] #FFFFFFAylık Kasko Ödemesi: "..fiyat,source,255,255,255,true)
        outputChatBox("#FF7F00[MG | Araç Sistemi] #FFFFFFKasko Bitiş Tarihi: "..yenitarih,source,255,255,255,true)
    else
        exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFKasko yenilemek için yeterli paran yok. Gereken Miktar: #FF7F00$"..fiyat,source,255,255,255,true)
    end
end)

function kaskokontrol(veriler)
    local data = dbPoll(veriler,0)
    for i,v in pairs(data) do
        if v["kaskodurum"] == "Var" then
            local time = getRealTime()
            local tarih = tostring(v["kaskotarihi"])
            local gun,ay2,yil
            if tostring(string.sub(tarih,1,1)) == "0" then
                gun = string.sub(tarih,2,2)
            else
                gun = string.sub(tarih,1,2)
            end
            if string.sub(tarih,4,4) == "0" then
                ay2 = string.sub(tarih,5,5)
            else
                ay2 = string.sub(tarih,4,5)
            end
            yil = string.sub(tarih,7,10)
            if tonumber(time.month+1) > tonumber(ay2) and tonumber(time.year+1900) > tonumber(yil) then 
                dbExec(db,"UPDATE araclar SET kaskodurum = ?, kaskotarihi = ? WHERE id = ?","Yok","Yok",v["id"])
            elseif tonumber(time.month+1) == tonumber(ay2) and tonumber(time.monthday) >= tonumber(gun) then 
                dbExec(db,"UPDATE araclar SET kaskodurum = ?, kaskotarihi = ? WHERE id = ?","Yok","Yok",v["id"])
            elseif tonumber(time.year+1900) > tonumber(yil) then  
                dbExec(db,"UPDATE araclar SET kaskodurum = ?, kaskotarihi = ? WHERE id = ?","Yok","Yok",v["id"])
            end
            if tonumber(time.month+1) == tonumber(ay2) and (tonumber(gun) - tonumber(time.monthday)) <= 5 then
                local durum = false
                local kalan = tostring(tonumber(tonumber(gun) - time.monthday))
                for i,v in pairs(uyarilar) do
                    if tostring(v[1]) == tostring(v["sahip"]) then
                        v[2] = kalan
                        durum = true
                    end
                end
                if durum == false then table.insert(uyarilar,{ v["sahip"],kalan,v["id"] }) end
            end
        end
    end
end

addEventHandler("onPlayerLogin",getRootElement(),function()
    dbQuery(kaskokontrol,db,"SELECT id,sahip,kaskodurum,kaskotarihi FROM araclar")
    local hesap = getAccountName(getPlayerAccount(source))
    setTimer(function()
    surebildiri(hesap)
    end,1000,0)
end)

function surebildiri(hesap)
    for i,v in pairs(uyarilar) do
        if tostring(v[1]) == tostring(hesap) then
            table.remove(uyarilar,i)
            if tostring(v[2]) ~= "0" then
                exports["hud"]:dm("#FF7F00[MG | Kasko Sistemi] #FFFFFFDikkat! "..v[3].." ID 'li aracının Kasko Süresinin bitmesine son "..v[2].." Gün Kaldı!",source,255,255,255,true)
            else
                exports["hud"]:dm("#FF7F00[MG | Kasko Sistemi] #FFFFFFDikkat! "..v[3].." ID 'li aracının Kasko Süresi bitmiştir.",source,255,255,255,true)
            end
        end
    end
end

addEvent("MG-CarPanel:TakasIstegiGonder",true)
addEventHandler("MG-CarPanel:TakasIstegiGonder",getRootElement(),function(digeroyuncu)
    if isGuestAccount(getPlayerAccount(digeroyuncu)) then exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFİstek Göndermek istediğin oyuncu hesabına giriş yapmadığı için işlem iptal edildi.",source,255,255,255,true) return end
    local hesap = getAccountName(getPlayerAccount(digeroyuncu))
    local oyuncuasdf = getAccount(hesap)
    local oyuncu = getAccountPlayer(oyuncuasdf)
    local digerhesap = getAccountName(getPlayerAccount(source))
    for i,v in pairs(takasistekleri) do
        if tostring(v[1]) == tostring(hesap) or tostring(v[2]) == tostring(digerhesap) or tostring(v[2]) == tostring(hesap) or tostring(v[1]) == tostring(digerhesap) then
            exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFOyuncu zaten başka bir takasta.",source,255,255,255,true)
            return 
        end
    end
    table.insert(takasistekleri,{ hesap,digerhesap,oyuncu,source })
    pl1 = getPlayerName(source):gsub("#%x%x%x%x%x%x","")
    pl2 = getPlayerName(oyuncu):gsub("#%x%x%x%x%x%x","")
    exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFBaşarıyla "..pl2.." 'e Takas Teklifi gönderdin!",source,255,255,255,true)
    exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFDikkat! "..pl1.." sana takas teklifi gönderdi. Kabul etmek için #ff7f00/takaskabul #ffffffyaz.",oyuncu,255,255,255,true)
end)

addCommandHandler("takaskabul",function(pl,cmd)
    local hesap = getAccountName(getPlayerAccount(pl))
    local find = false
    for i,v in pairs(takasistekleri) do
        if tostring(v[1]) == tostring(hesap) then
            find = true
            triggerClientEvent(v[3],"MG-CarPanel:TakasPanelGoster",v[3],"TeklifAlan")
            triggerClientEvent(v[4],"MG-CarPanel:TakasPanelGoster",v[4],"TeklifVeren")
        end
    end
    if find == false then exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFHerhangi bir takas teklifi almadın.",pl,255,255,255,true) end
end)

addEvent("MG-CarPanel:TakasKapatHerseyi",true)
addEventHandler("MG-CarPanel:TakasKapatHerseyi",getRootElement(),function()
    local hesap = getAccountName(getPlayerAccount(source))
    local digerininhesap
    local durum = false
    for i,v in pairs(takasistekleri) do
        if tostring(v[1]) == tostring(hesap) or tostring(v[2]) == tostring(hesap) then
            if tostring(v[1]) == tostring(hesap) then
                pl1 = getPlayerName(v[3]):gsub("#%x%x%x%x%x%x","")
                digerininhesap = tostring(v[2])
                triggerClientEvent(v[4],"MG-CarPanel:TakasPanelKapa",v[4])
                exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFDikkat! Takas İşlemini "..pl1.." iptal etti. Takas İşlemleri Sona erdi.",v[4],255,255,255,true)
                exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFDikkat! Takas İşlemini iptal ettin. Bu hareketin karşı tarafa bildirildi.",v[3],255,255,255,true)
            else
                digerininhesap = tostring(v[1])
                pl1 = getPlayerName(v[4]):gsub("#%x%x%x%x%x%x","")
                exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFDikkat! Takas İşlemini iptal ettin. Bu hareketin karşı tarafa bildirildi.",v[4],255,255,255,true)
                exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFDikkat! Takas İşlemini "..pl1.." iptal etti. Takas İşlemleri Sona erdi.",v[3],255,255,255,true)
                triggerClientEvent(v[3],"MG-CarPanel:TakasPanelKapa",v[3])
            end
            table.remove(takasistekleri,i)
        end
    end
    function sil()
        for i,v in pairs(kullanilanlar) do
            if tostring(v[2]) == tostring(hesap) or tostring(v[2]) == tostring(digerininhesap) then
                table.remove(kullanilanlar,i)
                durum = true
            end
        end
    end
    sil()
    durum = false
    for i,v in pairs(kullanilanlar) do
        if tostring(v[2]) == tostring(hesap) or tostring(v[2]) == tostring(digerininhesap) then
            durum = true   
        end
    end
    if durum == true then sil() end
    if durum == true then sil() end
end)

addEventHandler("onPlayerWasted",getRootElement(),function()
    local hesap = getAccountName(getPlayerAccount(source))
    local digerininhesap
    local durum = false
    local varmi = false
    for i,v in pairs(takasistekleri) do
        if tostring(v[1]) == tostring(hesap) or tostring(v[2]) == tostring(hesap) then
            varmi = true
            if tostring(v[1]) == tostring(hesap) then
                pl1 = getPlayerName(v[3]):gsub("#%x%x%x%x%x%x","")
                digerininhesap = tostring(v[2])
                triggerClientEvent(v[4],"MG-CarPanel:TakasPanelKapa",v[4])
                triggerClientEvent(v[3],"MG-CarPanel:TakasPanelKapa",v[3])
                exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFDikkat! "..pl1.." öldüğü için, Takas İşlemleri Sona erdi.",v[4],255,255,255,true)
                exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFDikkat! Takas İşlemi öldüğün için, sona erdi.",v[3],255,255,255,true)
            else
                pl1 = getPlayerName(v[4]):gsub("#%x%x%x%x%x%x","")
                digerininhesap = tostring(v[1])
                triggerClientEvent(v[4],"MG-CarPanel:TakasPanelKapa",v[4])
                triggerClientEvent(v[3],"MG-CarPanel:TakasPanelKapa",v[3])
                exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFDikkat! "..pl1.." öldüğü için, Takas İşlemleri Sona erdi.",v[3],255,255,255,true)
                exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFDikkat! Takas İşlemi öldüğün için, sona erdi.",v[4],255,255,255,true)
            end
            table.remove(takasistekleri,i)
        end
    end
    if varmi == true then
        function sil()
            for i,v in pairs(kullanilanlar) do
                if tostring(v[2]) == tostring(hesap) or tostring(v[2]) == tostring(digerininhesap) then
                    table.remove(kullanilanlar,i)
                    durum = true
                end
            end
        end
        sil()
        durum = false
        for i,v in pairs(kullanilanlar) do
            if tostring(v[2]) == tostring(hesap) or tostring(v[2]) == tostring(digerininhesap) then
                durum = true   
            end
        end
        if durum == true then sil() end
        if durum == true then sil() end
    end
end)

addEventHandler("onPlayerQuit",getRootElement(),function()
    local hesap = getAccountName(getPlayerAccount(source))
    local digerininhesap
    local durum = false
    local varmi = false
    for i,v in pairs(takasistekleri) do
        if tostring(v[1]) == tostring(hesap) or tostring(v[2]) == tostring(hesap) then
            varmi = true
            if tostring(v[1]) == tostring(hesap) then
                pl1 = getPlayerName(v[3]):gsub("#%x%x%x%x%x%x","")
                digerininhesap = tostring(v[2])
                triggerClientEvent(v[4],"MG-CarPanel:TakasPanelKapa",v[4])
                exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFDikkat! "..pl1.." Sunucudan Çıktığı için, Takas İşlemleri Sona erdi.",v[4],255,255,255,true)
            else
                pl1 = getPlayerName(v[4]):gsub("#%x%x%x%x%x%x","")
                digerininhesap = tostring(v[1])
                triggerClientEvent(v[3],"MG-CarPanel:TakasPanelKapa",v[3])
                exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFDikkat! "..pl1.." Sunucudan Çıktığı için, Takas İşlemleri Sona erdi.",v[3],255,255,255,true)
            end
            table.remove(takasistekleri,i)
        end
    end
    if varmi == true then
        function sil()
            for i,v in pairs(kullanilanlar) do
                if tostring(v[2]) == tostring(hesap) or tostring(v[2]) == tostring(digerininhesap) then
                    table.remove(kullanilanlar,i)
                    durum = true
                end
            end
        end
        sil()
        durum = false
        for i,v in pairs(kullanilanlar) do
            if tostring(v[2]) == tostring(hesap) or tostring(v[2]) == tostring(digerininhesap) then
                durum = true   
            end
        end
        if durum == true then sil() end
        if durum == true then sil() end
    end
end)

addEvent("MG-CarPanel:AracKontrol",true)
addEventHandler("MG-CarPanel:AracKontrol",getRootElement(),function(id,rol)
    local hesap = getAccountName(getPlayerAccount(source))
    if tonumber(id) < 1 then exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFSence böyle bir şey deneyeceğini tahmin etmedik mi?",source,255,255,255,true) return end
    local data = dbPoll(dbQuery(db,"SELECT sahip,aracid FROM araclar WHERE id = ?",id),-1)
    if tonumber(#data) == 0 then exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFGirdiğin ID 'ye sahip bir araç bulunamadı.",source,255,255,255,true) return end
    if tostring(data[1]["sahip"]) == tostring(hesap) then
        if tonumber(#kullanilanlar) > 0 then
            for index,value in pairs(kullanilanlar) do
                if tostring(value[1]) == tostring(id) then
                    exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFGirdiğin ID 'ye sahip aracı zaten ekledin.",source,255,255,255,true)
                    return
                end
            end
        end
        for i,v in pairs(takasistekleri) do
            if tostring(v[1]) == tostring(hesap) or tostring(v[2]) == tostring(hesap) then
                if tostring(rol) == "TeklifAlan" then
                    triggerClientEvent(v[3],"MG-CarPanel:TakasListeyeEkle1",v[3],id,tonumber(data[1]["aracid"]),"Alan","arac")
                    triggerClientEvent(v[4],"MG-CarPanel:TakasListeyeEkle1",v[4],id,tonumber(data[1]["aracid"]),"Alan","arac")
                else
                    triggerClientEvent(v[3],"MG-CarPanel:TakasListeyeEkle1",v[3],id,tonumber(data[1]["aracid"]),"Veren","arac")
                    triggerClientEvent(v[4],"MG-CarPanel:TakasListeyeEkle1",v[4],id,tonumber(data[1]["aracid"]),"Veren","arac")
                end
                table.insert(kullanilanlar,{ id,hesap,"","" })
            end
        end
    else
        exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFGirdiğin ID 'ye sahip araç, sana ait değil.",source,255,255,255,true)
    end
end)

addEvent("MG-CarPanel:ParaKontrol",true)
addEventHandler("MG-CarPanel:ParaKontrol",getRootElement(),function(para,rol)
    local hesap = getAccountName(getPlayerAccount(source))
    if tonumber(para) < 1000 then exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFPara eklemek için, en az 1000 birim vermen gerek.",source,255,255,255,true) return end
    local verilenpara = 0
    for i,v in pairs(kullanilanlar) do
        if tostring(v[2]) == tostring(hesap) and tostring(v[3]) ~= "" then
            verilenpara = verilenpara + tonumber(v[3])
        end
    end
    local parasi = getPlayerMoney(source) - tonumber(verilenpara)
    if parasi >= tonumber(para) then
        for i,v in pairs(takasistekleri) do
            if tostring(v[1]) == tostring(hesap) or tostring(v[2]) == tostring(hesap) then
                if tostring(rol) == "TeklifAlan" then
                    triggerClientEvent(v[3],"MG-CarPanel:TakasListeyeEkle1",v[3],"",para,"Alan","para")
                    triggerClientEvent(v[4],"MG-CarPanel:TakasListeyeEkle1",v[4],"",para,"Alan","para")
                else
                    triggerClientEvent(v[3],"MG-CarPanel:TakasListeyeEkle1",v[3],"",para,"Veren","para")
                    triggerClientEvent(v[4],"MG-CarPanel:TakasListeyeEkle1",v[4],"",para,"Veren","para")
                end
                table.insert(kullanilanlar,{ "",hesap,para,"" })
            end
        end
    else
        exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFYeterli paraya sahip değilsin.",source,255,255,255,true)
    end
end)

addEvent("MG-CarPanel:MjKontrol",true)
addEventHandler("MG-CarPanel:MjKontrol",getRootElement(),function(para,rol)
    local hesap = getAccountName(getPlayerAccount(source))
    if tonumber(para) < 20 then exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFMJ Eklemek için, en az 20 MJ vermen gerek.",source,255,255,255,true) return end
    local miktar2 = exports["marketpanel"]:mjsorgula(source)
    local miktar = tonumber(miktar2)
    if type(miktar) == "number" then
        local verilenmj = 0
        for i,v in pairs(kullanilanlar) do
            if tostring(v[2]) == tostring(hesap) and tostring(v[4]) ~= "" then
                verilenmj = verilenmj + tonumber(v[4])
            end
        end
        local verebilecegi = tonumber(miktar) - tonumber(verilenmj)
        if verebilecegi >= tonumber(para) then
            for i,v in pairs(takasistekleri) do
                if tostring(v[1]) == tostring(hesap) or tostring(v[2]) == tostring(hesap) then
                    if tostring(rol) == "TeklifAlan" then
                        triggerClientEvent(v[3],"MG-CarPanel:TakasListeyeEkle1",v[3],"",para,"Alan","mj")
                        triggerClientEvent(v[4],"MG-CarPanel:TakasListeyeEkle1",v[4],"",para,"Alan","mj")
                    else
                        triggerClientEvent(v[3],"MG-CarPanel:TakasListeyeEkle1",v[3],"",para,"Veren","mj")
                        triggerClientEvent(v[4],"MG-CarPanel:TakasListeyeEkle1",v[4],"",para,"Veren","mj")
                    end
                    table.insert(kullanilanlar,{ "",hesap,"",para })
                end
            end
        else
            exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFYeterli MJ 'n yok.",source,255,255,255,true)
        end
    else
        exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFMJ 'n olmadığı için ekleyemezsin.",source,255,255,255,true)
    end
end)

addEvent("MG-CarPanel:TakasKabul",true)
addEventHandler("MG-CarPanel:TakasKabul",getRootElement(),function()
    local hesap = getAccountName(getPlayerAccount(source))
    local digeri
    local oyuncu
    local varmi
    for i,v in pairs(takasistekleri) do
        if tostring(hesap) == tostring(v[1]) or tostring(hesap) == tostring(v[2]) then
            varmi = true
            if tostring(hesap) == tostring(v[1]) then
                digeri = v[2]
                oyuncu = v[4]
            else
                digeri = v[1]
                oyuncu = v[3]
            end
        end
    end
    if varmi == true then
        local bulunuomu = false
        for i,v in pairs(kabuledenler) do
            if tostring(hesap) == tostring(v[1]) or tostring(hesap) == tostring(v[2]) then
                if tostring(hesap) == tostring(v[1]) then exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFZaten işlemi kabul ettin. Sıra karşıda.",source,255,255,255,true) bulunuomu = true return
                else
                    for i,v in pairs(kullanilanlar) do
                        if tostring(hesap) == tostring(v[2]) then
                            if tostring(v[1]) ~= "" then
                                dbExec(db,"UPDATE araclar SET sahip = ? WHERE id = ?",digeri,tonumber(v[1]))
                            elseif tostring(v[3]) ~= "" then
                                takePlayerMoney(source,tonumber(v[3]))
                                givePlayerMoney(oyuncu,tonumber(v[3]))
                            elseif tostring(v[4]) ~= "" then
                                exports["marketpanel"]:mjtakas(source,oyuncu,tonumber(v[4]))
                            end
                        elseif tostring(digeri) == tostring(v[2]) then
                            if tostring(v[1]) ~= "" then
                                dbExec(db,"UPDATE araclar SET sahip = ? WHERE id = ?",hesap,tonumber(v[1]))
                            elseif tostring(v[3]) ~= "" then
                                takePlayerMoney(oyuncu,tonumber(v[3]))
                                givePlayerMoney(source,tonumber(v[3]))
                            elseif tostring(v[4]) ~= "" then
                                exports["marketpanel"]:mjtakas(oyuncu,source,tonumber(v[4]))
                            end
                        end
                    end
                    bulunuomu = true
                    tumverilerisil(hesap,digeri)
                    exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFTakas işlemi başarıyla gerçekleşti!",source,255,255,255,true) 
                    exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFTakas işlemi başarıyla gerçekleşti!",oyuncu,255,255,255,true) 
                    triggerClientEvent(source,"MG-CarPanel:TakasPanelKapa",source)
                    triggerClientEvent(oyuncu,"MG-CarPanel:TakasPanelKapa",oyuncu)
                end
            end
        end
        if bulunuomu == false then
            pl1 = getPlayerName(oyuncu):gsub("#%x%x%x%x%x%x","")
            exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFTakası Kabul Ettin! Karşıdaki oyuncu da kabul ettiğinde işlem gerçekleşecek.",source,255,255,255,true) 
            exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFHey! "..pl1.." Takası Kabul Etti! Eğer sende kabul edersen, takas gerçekleşecek.",oyuncu,255,255,255,true) 
            table.insert(kabuledenler,{ hesap,digeri })
        end
    else
        exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFİşlem başarısız oldu. Lütfen takas sistemini kapatın ve tekrar deneyin.",source,255,255,255,true)
    end
end)

function tumverilerisil(hesap,digeri)
    for i,v in pairs(kabuledenler) do
        if tostring(hesap) == v[1] or tostring(hesap) == v[2] then
            table.remove(kabuledenler,i)
        elseif tostring(digeri) == v[1] or tostring(digeri) == v[2] then
            table.remove(kabuledenler,i)
        end
    end
    for i,v in pairs(takasistekleri) do
        if tostring(hesap) == tostring(v[1]) or tostring(hesap) == tostring(v[2]) then
            table.remove(takasistekleri,i)
        elseif tostring(digeri) == tostring(v[1]) or tostring(digeri) == tostring(v[2]) then
            table.remove(takasistekleri,i)
        end
    end
    local durum = false
    function sil()
        for i,v in pairs(kullanilanlar) do
            if tostring(v[2]) == tostring(hesap) or tostring(v[2]) == tostring(digeri) then
                table.remove(kullanilanlar,i)
                durum = true
            end
        end
    end
    sil()
    durum = false
    for i,v in pairs(kullanilanlar) do
        if tostring(v[2]) == tostring(hesap) or tostring(v[2]) == tostring(digeri) then
            durum = true   
        end
    end
    if durum == true then sil() end
    if durum == true then sil() end
end
