local satinalinacak
local satisacikarilacak
local ida
local kaskoliste = { }
local kaskorani = 18
local takasistek = false
local font = guiCreateFont("files/ekfont.ttf",11)
local sx, sy = guiGetScreenSize ( )
local rol

-- Ana Panel
Genislikm,Uzunlukm = 727,339
Xm = (sx/2) - (Genislikm/2)
Ym = (sy/2) - (Uzunlukm/2)
mainwindow = guiCreateWindow(Xm, Ym, Genislikm, Uzunlukm, "Araç Panel", false)
guiWindowSetSizable(mainwindow, false)
guiSetVisible(mainwindow,false)

mainAracList = guiCreateGridList(9, 25, 330, 304, false, mainwindow)
guiGridListAddColumn(mainAracList, "Araç ID", 0.1)
guiGridListAddColumn(mainAracList, "Araç Markası", 0.6)
guiGridListAddColumn(mainAracList, "Kasko", 0.2)
mainAracIndirBtn = guiCreateButton(358, 44, 167, 48, "Aracını İndir", false, mainwindow)
guiSetFont(mainAracIndirBtn,font)
mainAracKaldirBtn = guiCreateButton(535, 44, 167, 48, "Aracını Kaldır", false, mainwindow)
guiSetFont(mainAracKaldirBtn,font)
mainAracBilgisiBtn = guiCreateButton(358, 109, 167, 48, "Araç Bilgisi", false, mainwindow)
guiSetFont(mainAracBilgisiBtn,font)
mainAraciCekBtn = guiCreateButton(535, 109, 167, 48, "Aracı Yanına Çek\n($1000)", false, mainwindow)
guiSetFont(mainAraciCekBtn,font)
mainAraciSatisaCikar = guiCreateButton(358, 176, 167, 48, "Aracı Satışa Çıkar", false, mainwindow)
guiSetFont(mainAraciSatisaCikar,font)
mainKaskoYaptirBtn = guiCreateButton(535, 176, 167, 48, "Kasko Yaptır", false, mainwindow)
guiSetFont(mainKaskoYaptirBtn,font)
mainSunucuyaSatBtn = guiCreateButton(358, 240, 167, 48, "Aracı Sunucuya Sat\n(Değerinin %50 'sine)", false, mainwindow)
guiSetFont(mainSunucuyaSatBtn,font)
mainAraciTakasEtBtn = guiCreateButton(535, 240, 167, 48, "Aracı Takas Et", false, mainwindow)
guiSetFont(mainAraciTakasEtBtn,font)
mainInfoLbl = guiCreateLabel(460, 306, 139, 13, "MADDE GAMING | Copyright 2023", false, mainwindow)
guiSetFont(mainInfoLbl, "default-small")
mainKapatBtn = guiCreateButton(703, 0, 23, 20, "X", false, mainwindow)    

-- Araç Bilgi ve Satış Paneli
Genislikb,Uzunlukb = 410,440
Xb = (sx/2) - (Genislikb/2)
Yb = (sy/2) - (Uzunlukb/2)
bilgiwindow = guiCreateWindow(Xb, Yb, Genislikb, Uzunlukb, "Araç Bilgi Panel", false)
guiWindowSetSizable(bilgiwindow, false)
guiSetVisible(bilgiwindow,false)

bilgiAracModelLbl = guiCreateLabel(30, 36, 354, 20, "● Araç Modeli = ", false, bilgiwindow)
guiSetFont(bilgiAracModelLbl, font)
bilgiAracSahibiLbl = guiCreateLabel(30, 66, 354, 20, "● Araç Sahibi =  ", false, bilgiwindow)
guiSetFont(bilgiAracSahibiLbl, font)
bilgiAracOncekiSahibiLbl = guiCreateLabel(30, 96, 354, 20, "● Araç Önceki Sahibi =", false, bilgiwindow)
guiSetFont(bilgiAracOncekiSahibiLbl, font)
bilgiAracTeslimTarihiLbl = guiCreateLabel(30, 126, 354, 20, "● Araç Teslim Tarihi =", false, bilgiwindow)
guiSetFont(bilgiAracTeslimTarihiLbl, font)
bilgiAracKaskoLbl = guiCreateLabel(30, 156, 354, 20, "● Araç Kaskosu = ", false, bilgiwindow)
guiSetFont(bilgiAracKaskoLbl, font)
bilgiAracSatisFiyatLbl = guiCreateLabel(30, 186, 354, 20, "● Araç Satış Fiyatı = ", false, bilgiwindow)
guiSetFont(bilgiAracSatisFiyatLbl, font)
bilgiAracHandiLbl = guiCreateLabel(30, 216, 354, 20, "● Araç Handı = ", false, bilgiwindow)
guiSetFont(bilgiAracHandiLbl, font)
bilgiAracDurumuLbl = guiCreateLabel(30, 246, 354, 20, "● Araç Durumu = ", false, bilgiwindow)
guiSetFont(bilgiAracDurumuLbl, font)
bilgiOncekiFiyatiLbl = guiCreateLabel(30, 276, 354, 20, "● Araç Önceki Fiyatı = ", false, bilgiwindow)
guiSetFont(bilgiOncekiFiyatiLbl, font)
bilgiAracIDlbl = guiCreateLabel(30, 306, 354, 20, "● Araç ID 'si = ", false, bilgiwindow)
guiSetFont(bilgiAracIDlbl, font)
bilgiGeriBtn = guiCreateButton(30, 368, 152, 50, "Geri", false, bilgiwindow)
bilgiSatinAlBtn = guiCreateButton(222, 368, 152, 50, "Satın Al", false, bilgiwindow)
guiSetFont(bilgiGeriBtn,font)
guiSetFont(bilgiSatinAlBtn,font)
bilgiCizgiLbl = guiCreateLabel(0, 336, 412, 15, "⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻", false, bilgiwindow)    

-- Fiyat Panel
Genislikf,Uzunlukf = 317,168
Xf = (sx/2) - (Genislikf/2)
Yf = (sy/2) - (Uzunlukf/2)
fiyatwindow = guiCreateWindow(Xf, Yf, Genislikf, Uzunlukf, "Aracını ne kadara satmak istersin?", false)
guiWindowSetSizable(fiyatwindow, false)
guiSetVisible(fiyatwindow,false)
   
fiyatMiktarTxt = guiCreateEdit(37, 50, 238, 36, "Lütfen fiyat giriniz.", false, fiyatwindow)
guiSetFont(fiyatMiktarTxt,font)
fiyatGeriBtn = guiCreateButton(20, 101, 132, 43, "Geri", false, fiyatwindow)
guiSetFont(fiyatGeriBtn,font)
fiyatSatisaCikarBtn = guiCreateButton(162, 101, 132, 43, "Satışa Çıkar", false, fiyatwindow)   
guiSetFont(fiyatSatisaCikarBtn,font)

-- Takas Panel
Genislikt,Uzunlukt = 625,460
Xt = (sx/2) - (Genislikt/2)
Yt = (sy/2) - (Uzunlukt/2)
takaswindow = guiCreateWindow(Xt, Yt, Genislikt, Uzunlukt, "Madde Gaming | Takas Sistemi", false)
guiWindowSetSizable(takaswindow, false)
guiSetVisible(takaswindow,false)

takasTeklifGonderenList = guiCreateGridList(14, 29, 293, 166, false, takaswindow)
guiGridListAddColumn(takasTeklifGonderenList, "Ürün Adı", 0.2)
guiGridListAddColumn(takasTeklifGonderenList, "Ürün Detayı", 0.6)
takasTeklifAlanList = guiCreateGridList(317, 29, 293, 166, false, takaswindow)
guiGridListAddColumn(takasTeklifAlanList, "Ürün Adı", 0.2)
guiGridListAddColumn(takasTeklifAlanList, "Ürün Detayı", 0.6)
takasInfoLbl = guiCreateLabel(45, 208, 540, 49, "Takas Sistemine Hoş Geldin. Sol Taraftaki liste senin eklediğin ürünler. Sağ taraf ise karşıdaki kişinin.\nPara eklemek için aşağıdaki boşluğa miktarını gir. Araç Eklemek için, eklemek istediğin aracın ID 'sini\nGir. Eğer MJ Eklemek istiyorsan MJ Miktarını Gir. Unutma takas işlemleri geri alınamaz.", false, takaswindow)
takasMiktarTxt = guiCreateEdit(166, 268, 297, 35, "Araç ID, Para Miktarı veya MJ Miktarı girin.", false, takaswindow)
takasParaEkleBtn = guiCreateButton(24, 315, 182, 55, "Para Ekle", false, takaswindow)
guiSetFont(takasParaEkleBtn, font)
takasAracEkleBtn = guiCreateButton(220, 315, 182, 55, "Araç Ekle", false, takaswindow)
guiSetFont(takasAracEkleBtn, font)
takasMJEkle = guiCreateButton(412, 315, 182, 55, "MJ Ekle", false, takaswindow)
guiSetFont(takasMJEkle, font)
takasKabulBtn = guiCreateButton(220, 380, 182, 55, "Takası Kabul Et", false, takaswindow)
guiSetFont(takasKabulBtn, font)
takasKapatBtn = guiCreateButton(601, 0, 23, 20, "X", false, takaswindow)    

--Takas İstek Panel
local pg4,pu4 = 260,390
local x4,y4 = (sx-pg4)/2,(sy-pu4)/2

takistekwindow = guiCreateWindow(x4,y4,pg4,pu4,"Takas İşlemleri", false)
guiWindowSetSizable(takistekwindow, false)
guiSetVisible(takistekwindow, false)

takisteInfoLbl = guiCreateLabel(0,25,pg4,30,"Sadece 20m yakınınızdaki oyuncular listede\n gözükür.",false,takistekwindow)
guiSetFont(takisteInfoLbl,"default-bold-small")

takisteOyuncuList = guiCreateGridList(10,60,pg4-20,pu4-100,false,takistekwindow)
guiGridListAddColumn(takisteOyuncuList,"Oyuncular",0.85)

takisteTakasGonder = guiCreateButton(10,pu4-35,120,25,"Gönder",false,takistekwindow)
guiSetFont(takisteTakasGonder, font)
takisteIptalBtn = guiCreateButton(10+125,pu4-35,115,25,"İptal",false,takistekwindow)
guiSetFont(takisteIptalBtn, font)

--Kasko Panel
Genislikk,Uzunlukk = 466,338
Xk = (sx/2) - (Genislikk/2)
Yk = (sy/2) - (Uzunlukk/2)
kaskowindow = guiCreateWindow(Xk, Yk, Genislikk, Uzunlukk, "Madde Gaming | Araç Kasko Sistemi", false)
guiWindowSetSizable(kaskowindow, false)
guiSetVisible(kaskowindow,false)

kaskoKapatBtn = guiCreateButton(442, 0, 24, 20, "X", false, kaskowindow)   
kaskoList = guiCreateGridList(9, 25, 447, 177, false, kaskowindow)
guiGridListAddColumn(kaskoList, "Araç ID", 0.1)
guiGridListAddColumn(kaskoList, "Araç Markası", 0.5)
guiGridListAddColumn(kaskoList, "Araç Kasko Durumu", 0.3)
kaskoInfoLbl = guiCreateLabel(84, 206, 306, 38, " Aracınızın Markasına göre kasko fiyatı değişmektedir.\n       Kasko her ay günü gelmeden ödenmelidir.", false, kaskowindow)
KaskoSirketiBtn = guiCreateButton(36, 277, 120, 44, "Kasko Şirketi Kur\n(Yakında)", false, kaskowindow)
kaskoYenileBtn = guiCreateButton(166, 277, 120, 44, "Kaskoyu Yenile", false, kaskowindow)
kaskoYaptirBtn = guiCreateButton(296, 277, 120, 44, "Kasko Yaptır", false, kaskowindow)
kaskoSonOdemeTarihiLbl = guiCreateLabel(26, 246, 215, 21, "Son Ödeme Tarihi = (Araç Seçiniz...)", false, kaskowindow)
kaskoAylikFiyatLbl = guiCreateLabel(246, 246, 210, 21, "Aylık Kasko Fiyatı = (Araç Seçiniz...)", false, kaskowindow)    

-- KODLAR -- 

bindKey("F4","down",function()
    if guiGetVisible(takaswindow) == true then
        return
    elseif guiGetVisible(fiyatwindow) == true then
        guiSetVisible(fiyatwindow,false)
    elseif guiGetVisible(bilgiwindow) == true then
        guiSetVisible(bilgiwindow,false)
    elseif guiGetVisible(kaskowindow) == true then
        guiSetVisible(kaskowindow,false)
    elseif guiGetVisible(takistekwindow) == true then
        guiSetVisible(takistekwindow,false)
    end
    if guiGetVisible(mainwindow) == true then
        guiSetVisible(mainwindow,false)
        showCursor(false)
    else
        triggerServerEvent("MG-CarPanel:AraclariListele",localPlayer)
    end
end)

addEventHandler("onClientGUIClick",getRootElement(),function()
    if source == mainAracBilgisiBtn then
        local sel = guiGridListGetSelectedItem(mainAracList)
        if sel ~= -1 then
            local id = guiGridListGetItemText(mainAracList,sel,1)
            triggerServerEvent("MG-CarPanel:AracBilgiSatis",localPlayer,id,"bilgi")
        else
            exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFHakkında Bilgi sahibi olmak istediğiniz aracı seçiniz.",255,255,255,true)
        end
    elseif source == mainAraciSatisaCikar then
        local sel = guiGridListGetSelectedItem(mainAracList)
        if sel ~= -1 then
            satisacikarilacak = guiGridListGetItemText(mainAracList,sel,1)
            guiSetVisible(mainwindow,false)
            guiSetVisible(fiyatwindow,true)
        else
            exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFSatışa çıkarmak istediğiniz aracı seçiniz.",255,255,255,true)
        end
    elseif source == mainKaskoYaptirBtn then
        triggerServerEvent("MG-CarPanel:KaskoListele",localPlayer,id)
    elseif source == mainKapatBtn then
        guiSetVisible(mainwindow,false)
        showCursor(false)
    elseif source == kaskoKapatBtn then
        guiSetVisible(kaskowindow,false)
        showCursor(false)
    elseif source == fiyatMiktarTxt then
        guiSetText(fiyatMiktarTxt,"")
    elseif source == takasKapatBtn then
        guiSetVisible(takaswindow,false)
        guiSetInputEnabled(false)
        showCursor(false)
        guiGridListClear(takasTeklifAlanList)
        guiGridListClear(takasTeklifGonderenList)
        triggerServerEvent("MG-CarPanel:TakasKapatHerseyi",localPlayer)
    elseif source == bilgiGeriBtn then
        guiSetVisible(bilgiwindow,false)
        if guiGetText(bilgiGeriBtn) == "Kapat" then
            showCursor(false)
        else
            guiSetVisible(mainwindow,true)
        end
    elseif source == fiyatGeriBtn then
        guiSetVisible(fiyatwindow,false)
        guiSetVisible(mainwindow,true)
    elseif source == bilgiSatinAlBtn then
        if guiGetText(bilgiSatinAlBtn) == "Paneli Kapat" then
            guiSetVisible(bilgiwindow,false)
            showCursor(false)
        else
            if guiGetText(bilgiAracDurumuLbl) ==  "● Araç Durumu = Satılık, Sıfır Araba." then
                local fiyati = aracfiyat[satinalinacak]
                triggerServerEvent("MG-CarPanel:AraciSatinAl1",localPlayer,satinalinacak,fiyati)
            else
                triggerServerEvent("MG-CarPanel:AraciSatinAl2",localPlayer,ida)
            end
            guiSetVisible(bilgiwindow,false)
            showCursor(false)
        end
    elseif source == mainAracIndirBtn then
        local sel = guiGridListGetSelectedItem(mainAracList)
        if sel ~= -1 then
            local id = guiGridListGetItemText(mainAracList,sel,1)
            triggerServerEvent("MG-CarPanel:AracIndir",localPlayer,id,"-","-")
            guiSetVisible(mainwindow,false)
            showCursor(false)
        else
            exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFListeden İndirmek istediğiniz aracı seçiniz.",255,255,255,true)
        end
    elseif source == mainAracKaldirBtn then
        local sel = guiGridListGetSelectedItem(mainAracList)
        if sel ~= -1 then
            local id = guiGridListGetItemText(mainAracList,sel,1)
            triggerServerEvent("MG-CarPanel:AracKaldir",localPlayer,id)
            guiSetVisible(mainwindow,false)
            showCursor(false)
        else
            exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFListeden Kaldırmak istediğiniz aracı seçiniz.",255,255,255,true)
        end
    elseif source == mainAraciCekBtn then
        local sel = guiGridListGetSelectedItem(mainAracList)
        if sel ~= -1 then
            local id = guiGridListGetItemText(mainAracList,sel,1)
            triggerServerEvent("MG-CarPanel:AracYaninaCek",localPlayer,id)
            guiSetVisible(mainwindow,false)
            showCursor(false)
        else
            exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFListeden yanına çekmek istediğin aracı seç.",255,255,255,true)
        end
    elseif source == fiyatSatisaCikarBtn then
        local fiyat = guiGetText(fiyatMiktarTxt)
        local sa = tonumber(fiyat)
        if type(sa) ~= "number" then exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFLütfen sayı girdiğine emin ol.",255,255,255,true) return end 
        if tonumber(fiyat) < 100 then
            exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFMinimum 100 birime araç satabilirsin.",255,255,255,true) return
        end
        triggerServerEvent("MG-CarPanel:AracIndir",localPlayer,satisacikarilacak,fiyat,"satis")
        guiSetVisible(fiyatwindow,false)
        showCursor(false)
    elseif source == mainSunucuyaSatBtn then
        local sel = guiGridListGetSelectedItem(mainAracList)
        if sel ~= -1 then
            local txt = guiGetText(mainSunucuyaSatBtn) 
            if txt == "Aracı Sunucuya Sat\n(Değerinin %50 'sine)" then
                guiSetText(mainSunucuyaSatBtn,"Sunucuya Sat\n(3)")
            elseif txt == "Sunucuya Sat\n(3)" then
                guiSetText(mainSunucuyaSatBtn,"Sunucuya Sat\n(2)")
            elseif txt == "Sunucuya Sat\n(2)" then
                guiSetText(mainSunucuyaSatBtn,"Sunucuya Sat\n(1)")
            elseif txt == "Sunucuya Sat\n(1)" then
                local fiyat
                local icanseemybabyswinging = guiGridListGetItemText(mainAracList,guiGridListGetSelectedItem(mainAracList),2)
                local id = guiGridListGetItemText(mainAracList,guiGridListGetSelectedItem(mainAracList),1)
                for i,v in pairs(aracmodel) do
                    if tostring(v) == tostring(icanseemybabyswinging) then
                        fiyat = aracfiyat[i]
                    end
                end
                if type(fiyat) == "number" then 
                    guiSetText(mainSunucuyaSatBtn,"Aracı Sunucuya Sat\n(Değerinin %50 'sine)")
                    triggerServerEvent("MG-CarPanel:SunucuyaSat",localPlayer,id,fiyat)
                    guiSetVisible(mainwindow,false)
                    showCursor(false)
                else
                    exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFNadir bir hatayla karşılaşıldı, Sunucu Sahibi Burak Mrx 'e bildirin.",255,255,255,true)
                end
            end
        else
            exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFSunucuya satmak istediğin arabayı seç.",255,255,255,true)
        end
    elseif source == kaskoList then
        local sel = guiGridListGetSelectedItem(kaskoList)
        if sel ~= -1 then
            local id = guiGridListGetItemText(kaskoList,sel,1) 
            for i,v in pairs(kaskoliste) do
                if tostring(v[1]) == tostring(id) then
                    local fiyatasd = aracfiyat[tonumber(v[2])]
                    local fiyat = math.floor(tonumber(fiyatasd) / kaskorani)
                    guiSetText(kaskoSonOdemeTarihiLbl,"Son Ödeme Tarihi = "..tostring(v[3]))
                    guiSetText(kaskoAylikFiyatLbl,"Aylık Kasko Fiyatı = "..fiyat)
                end
            end
        else
            guiSetText(kaskoSonOdemeTarihiLbl,"Son Ödeme Tarihi = (Araç Seçiniz...)")
            guiSetText(kaskoAylikFiyatLbl,"Aylık Kasko Fiyatı = (Araç Seçiniz...)")
        end
    elseif source == KaskoSirketiBtn then
        exports["hud"]:dm("#FF7F00[MG | Geliştirici Ekibi] #FFFFFFBu hizmet yakında sunucumuza gelecek. Bu buton, panel tasarımının hazır olması için konuldu.",255,255,255,true)
    elseif source == kaskoYenileBtn then
        local sel = guiGridListGetSelectedItem(kaskoList)
        if sel ~= -1 then
            local gg = guiGridListGetItemText(kaskoList,sel,3)
            if gg ~= "Yok" then
                local id = guiGridListGetItemText(kaskoList,sel,1)
                local fiyat,tarih
                for i,v in pairs(kaskoliste) do
                    if tostring(v[1]) == tostring(id) then
                        local fiyatasd = aracfiyat[tonumber(v[2])]
                        fiyat = math.floor(tonumber(fiyatasd) / kaskorani)
                        tarih = tostring(v[3])
                    end
                end
                triggerServerEvent("MG-CarPanel:KaskoYenileme",localPlayer,id,fiyat,tarih)
                guiSetVisible(kaskowindow,false)
                showCursor(false)
                guiSetText(kaskoSonOdemeTarihiLbl,"Son Ödeme Tarihi = (Araç Seçiniz...)")
                guiSetText(kaskoAylikFiyatLbl,"Aylık Kasko Fiyatı = (Araç Seçiniz...)")
            else
                exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFSeçtiğin aracın kaskosu olmadığı için yenileme işlemi başarısız. Yenilemek için kasko yaptır.",255,255,255,true)
            end
        else
            exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFLütfen listeden kaskosunu yenilemek istediğin aracı seç.",255,255,255,true)
        end
    elseif source == kaskoYaptirBtn then
        local sel = guiGridListGetSelectedItem(kaskoList)
        if sel ~= -1 then
            if guiGridListGetItemText(kaskoList,sel,3) == "Yok" then
                local id = guiGridListGetItemText(kaskoList,sel,1)
                local fiyat 
                for i,v in pairs(kaskoliste) do
                    if tostring(v[1]) == tostring(id) then
                        local fiyatasd = aracfiyat[tonumber(v[2])]
                        fiyat = math.floor(tonumber(fiyatasd) / kaskorani)
                    end
                end
                triggerServerEvent("MG-CarPanel:KaskoYaptirma",localPlayer,id,fiyat)
                guiSetVisible(kaskowindow,false)
                showCursor(false)
                guiSetText(kaskoSonOdemeTarihiLbl,"Son Ödeme Tarihi = (Araç Seçiniz...)")
                guiSetText(kaskoAylikFiyatLbl,"Aylık Kasko Fiyatı = (Araç Seçiniz...)")
            else
            exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFBu aracın zaten kaskosu var.",255,255,255,true)
            end
        else
            exports["hud"]:dm("#FF7F00[MG | Araç Sistemi] #FFFFFFLütfen listeden kasko yaptırmak istediğin aracı seç.",255,255,255,true)
        end
    elseif source == mainAraciTakasEtBtn then
        local liste = takisteOyuncuList
        guiGridListClear(liste)
        local x,y,z = getElementPosition(localPlayer)
        for i,oyuncu in pairs(getElementsByType("player",root,true)) do
            if localPlayer ~= oyuncu then
                local px,py,pz = getElementPosition(oyuncu)
                if getDistanceBetweenPoints3D(x,y,z,px,py,pz) <= 20 then
                    local isim = getPlayerName(oyuncu):gsub("#%x%x%x%x%x%x","")
                    local row = guiGridListAddRow(liste)
                    guiGridListSetItemText(liste,row,1,isim,false,false)
                    guiGridListSetItemData(liste,row,1,oyuncu)	
                end
            end	
        end
        guiSetVisible(mainwindow,false)
        guiSetVisible(takistekwindow,true)
    elseif source == takisteTakasGonder then
        local sel = guiGridListGetSelectedItem(takisteOyuncuList)
        if sel ~= -1 then
            if takasistek == false then
                takasistek = true
                local istekgonderilen = guiGridListGetItemData(takisteOyuncuList,sel,1)
                triggerServerEvent("MG-CarPanel:TakasIstegiGonder",localPlayer,istekgonderilen)
                guiSetVisible(takistekwindow,false)
                showCursor(false)
                setTimer(function()
                    takasistek = false
                end,180000,0)
            else
                exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFHer 3 dakikada 1 kere takas isteği gönderebilirsin.",255,255,255,true)
            end
        else
            exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFLütfen Takas isteği göndermek istediğinz kişiyi seçin.",255,255,255,true)
        end
    elseif source == takisteIptalBtn then
        guiSetVisible(takistekwindow,false)
        showCursor(false)
    elseif source == takasAracEkleBtn then
        local para2 = guiGetText(takasMiktarTxt)
        local id = tonumber(para2)
        if type(id) ~= "number" then exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFLütfen ID girdiğine emin ol.",255,255,255,true) return end 
        triggerServerEvent("MG-CarPanel:AracKontrol",localPlayer,id,rol)
    elseif source == takasMiktarTxt then
        guiSetText(takasMiktarTxt,"")
    elseif source == takasParaEkleBtn then
        local para2 = guiGetText(takasMiktarTxt)
        local para = tonumber(para2)
        if type(para) ~= "number" then exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFLütfen Para Miktarı girdiğine emin ol.",255,255,255,true) return end 
        triggerServerEvent("MG-CarPanel:ParaKontrol",localPlayer,para,rol)
    elseif source == takasMJEkle then
        local para2 = guiGetText(takasMiktarTxt)
        local para = tonumber(para2)
        if type(para) ~= "number" then exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFLütfen MJ Miktarı girdiğine emin ol.",255,255,255,true) return end 
        triggerServerEvent("MG-CarPanel:MjKontrol",localPlayer,para,rol)
    elseif source == takasKabulBtn then
        local v1,v2 = guiGridListGetItemData(takasTeklifAlanList,1,1), guiGridListGetItemData(takasTeklifGonderenList,1,1)
        if tostring(v1) == "" or tostring(v2) == "" then exports["hud"]:dm("#FF7F00[MG | Takas Sistemi] #FFFFFFKarşılıksız takas olmaz. Lütfen ürün ekle.",255,255,255,true) return end 
        triggerServerEvent("MG-CarPanel:TakasKabul",localPlayer)
    end
end)

addEvent("MG-CarPanel:SatisBilgilendirme",true)
addEventHandler("MG-CarPanel:SatisBilgilendirme",getRootElement(),function(veriler)
    satinalinacak = veriler[1]["aracid"]
    ida = veriler[1]["id"]
    local model = aracmodel[tonumber(veriler[1]["aracid"])]
    local distance = veriler[1]["km"] or 0
    local newkm = tostring(math.floor(distance/1000)).." km"
    guiSetVisible(bilgiSatinAlBtn,true)
    guiSetText(bilgiGeriBtn,"Kapat")
    guiSetText(bilgiSatinAlBtn,"Aracı Satın Al")
    guiSetText(bilgiAracModelLbl,"● Araç Modeli = "..model)
    guiSetText(bilgiAracSahibiLbl,"● Araç Sahibi = "..veriler[1]["sahip"])
    guiSetText(bilgiAracOncekiSahibiLbl,"● Araç Önceki Sahibi = "..veriler[1]["araconcekisahibi"] or "Yok")
    guiSetText(bilgiAracTeslimTarihiLbl,"● Araç Teslim Tarihi = "..veriler[1]["aracteslimtarihi"])
    guiSetText(bilgiAracKaskoLbl,"● Araç Kaskosu = "..veriler[1]["kaskodurum"])
    guiSetText(bilgiAracSatisFiyatLbl,"● Araç Satış Fiyatı = "..veriler[1]["aracsatisfiyat"])
    guiSetText(bilgiAracHandiLbl,"● Araç KM = "..tostring(newkm))
    guiSetText(bilgiAracDurumuLbl,"● Araç Durumu = "..veriler[1]["aracdurumu"])
    if tostring(veriler[1]["araconcekifiyat"]) == "" then
        guiSetText(bilgiOncekiFiyatiLbl,"● Araç Önceki Fiyatı = Yok")
    else
        guiSetText(bilgiOncekiFiyatiLbl,"● Araç Önceki Fiyatı = "..veriler[1]["araconcekifiyat"])
    end
    guiSetText(bilgiAracIDlbl,"● Araç ID 'si = "..veriler[1]["id"])
    guiSetVisible(bilgiwindow,true)
    showCursor(true)
end)

function aracsatinal(aracid,fiyati)
    satinalinacak = aracid
    local model = aracmodel[aracid]
    guiSetVisible(bilgiSatinAlBtn,true)
    guiSetText(bilgiGeriBtn,"Kapat")
    guiSetText(bilgiSatinAlBtn,"Aracı Satın Al")
    guiSetText(bilgiAracModelLbl,"● Araç Modeli = "..model)
    guiSetText(bilgiAracSahibiLbl,"● Araç Sahibi = Sunucu")
    guiSetText(bilgiAracOncekiSahibiLbl,"● Araç Önceki Sahibi = Yok, Araç Sıfır.")
    guiSetText(bilgiAracTeslimTarihiLbl,"● Araç Teslim Tarihi = Yok, Araç Sıfır.")
    guiSetText(bilgiAracKaskoLbl,"● Araç Kaskosu = Yok, Araç Sıfır.")
    guiSetText(bilgiAracSatisFiyatLbl,"● Araç Satış Fiyatı = "..tostring(fiyati))
    guiSetText(bilgiAracHandiLbl,"● Araç Handı = Yok, Araç Sıfır.")
    guiSetText(bilgiAracDurumuLbl,"● Araç Durumu = Satılık, Sıfır Araba.")
    guiSetText(bilgiOncekiFiyatiLbl,"● Araç KM = 0 KM")
    guiSetText(bilgiAracIDlbl,"● Araç ID 'si = Yok, Araç Sisteme kayıtlı değil.")
    guiSetVisible(bilgiwindow,true)
    showCursor(true)
end

addEvent("MG-CarPanel:BilgiEkrani",true)
addEventHandler("MG-CarPanel:BilgiEkrani",getRootElement(),function(veri)
    local distance = veri[1]["km"] or 0
    local newkm = tostring(math.floor(distance/1000)).." km"
    guiSetText(bilgiSatinAlBtn,"Paneli Kapat")
    guiSetText(bilgiGeriBtn,"Geri")
    guiSetText(bilgiAracModelLbl,"● Araç Modeli = "..veri[1]["aracid"])
    guiSetText(bilgiAracSahibiLbl,"● Araç Sahibi = "..veri[1]["sahip"])
    guiSetText(bilgiAracOncekiSahibiLbl,"● Araç Önceki Sahibi = "..veri[1]["araconcekisahibi"])
    guiSetText(bilgiAracTeslimTarihiLbl,"● Araç Teslim Tarihi = "..veri[1]["aracteslimtarihi"])
    guiSetText(bilgiAracKaskoLbl,"● Araç Kaskosu = "..veri[1]["kaskodurum"])
    guiSetText(bilgiAracSatisFiyatLbl,"● Araç Satış Fiyatı = "..veri[1]["aracsatisfiyat"] or "Satışta Değil")
    guiSetText(bilgiAracHandiLbl,"● Araç KM = "..tostring(newkm))
    guiSetText(bilgiAracDurumuLbl,"● Araç Durumu = "..veri[1]["aracdurumu"])
    if tostring(veri[1]["araconcekifiyat"]) == "" then
        guiSetText(bilgiOncekiFiyatiLbl,"● Araç Önceki Fiyatı = Yok")
    else
        guiSetText(bilgiOncekiFiyatiLbl,"● Araç Önceki Fiyatı = "..veri[1]["araconcekifiyat"])
    end
    guiSetText(bilgiAracIDlbl,"● Araç ID 'si = "..veri[1]["id"])
    guiSetVisible(mainwindow,false)
    guiSetVisible(bilgiwindow,true)
end)

addEvent("MG-CarPanel:TekrarClienteGonder",true)
addEventHandler("MG-CarPanel:TekrarClienteGonder",getRootElement(),function(veriler)
    guiGridListClear(mainAracList)
    guiSetText(mainSunucuyaSatBtn,"Aracı Sunucuya Sat\n(Değerinin %50 'sine)")
    for i,v in pairs(veriler) do
        local modeli = aracmodel[tonumber(v["aracid"])]
        local row = guiGridListAddRow(mainAracList)
        guiGridListSetItemText(mainAracList,row,1,v["id"],false,false)
        guiGridListSetItemText(mainAracList,row,2,modeli,false,false)
        guiGridListSetItemText(mainAracList,row,3,v["kaskodurum"],false,false)
        if (v["indirme"] == "indirildi") then
            guiGridListSetItemColor(mainAracList,row,1,0,128,0)
            guiGridListSetItemColor(mainAracList,row,2,0,128,0)
            guiGridListSetItemColor(mainAracList,row,3,0,128,0)
        end
    end
    guiSetVisible(mainwindow,true)
    showCursor(true)
end)

addEvent("MG-CarPanel:TekrarClienteGonder2",true)
addEventHandler("MG-CarPanel:TekrarClienteGonder2",getRootElement(),function(data)
    guiGridListClear(kaskoList)
    kaskoliste = { }
    for i,v in pairs(data) do
        local row = guiGridListAddRow(kaskoList)
        local model = aracmodel[tonumber(v["aracid"])]
        guiGridListSetItemText(kaskoList,row,1,tostring(v["id"]),false,false)
        guiGridListSetItemText(kaskoList,row,2,model,false,false)
        guiGridListSetItemText(kaskoList,row,3,tostring(v["kaskodurum"]),false,false)
        table.insert(kaskoliste,{ v["id"],v["aracid"],v["kaskotarihi"] })
    end
    guiSetVisible(mainwindow,false)
    guiSetVisible(kaskowindow,true)
end)

addEvent("MG-CarPanel:TakasPanelGoster",true)
addEventHandler("MG-CarPanel:TakasPanelGoster",getRootElement(),function(durums)
    if tostring(durums) == "TeklifAlan" then
        rol = "TeklifAlan"
        guiSetText(takasInfoLbl,"Takas Sistemine Hoş Geldin. Sağ Taraftaki liste senin eklediğin ürünler. Sol taraf ise karşıdaki kişinin.\nPara eklemek için aşağıdaki boşluğa miktarını gir. Araç Eklemek için, eklemek istediğin aracın ID 'sini\nGir. Eğer MJ Eklemek istiyorsan MJ Miktarını Gir. Unutma takas işlemleri geri alınamaz.")
        guiSetVisible(takaswindow,true)
        guiSetInputEnabled(false)
        showCursor(true)
    elseif tostring(durums) == "TeklifVeren" then
        rol = "TeklifVeren"
        guiSetText(takasInfoLbl,"Takas Sistemine Hoş Geldin. Sol Taraftaki liste senin eklediğin ürünler. Sağ taraf ise karşıdaki kişinin.\nPara eklemek için aşağıdaki boşluğa miktarını gir. Araç Eklemek için, eklemek istediğin aracın ID 'sini\nGir. Eğer MJ Eklemek istiyorsan MJ Miktarını Gir. Unutma takas işlemleri geri alınamaz.")
        guiSetVisible(takaswindow,true)
        showCursor(true)
        guiSetInputEnabled(false)
    end
end)

addEvent("MG-CarPanel:TakasPanelKapa",true)
addEventHandler("MG-CarPanel:TakasPanelKapa",getRootElement(),function()
    guiSetVisible(takaswindow,false)
    showCursor(false)
    guiSetInputEnabled(false)
    guiGridListClear(takasTeklifAlanList)
    guiGridListClear(takasTeklifGonderenList)
end)

addEvent("MG-CarPanel:TakasListeyeEkle1",true)
addEventHandler("MG-CarPanel:TakasListeyeEkle1",getRootElement(),function(id,aracid,kim,ne)
    if tostring(ne) == "arac" then
        if tostring(kim) == "Alan" then
            local row = guiGridListAddRow(takasTeklifAlanList)
            local model = aracmodel[tonumber(aracid)]
            guiGridListSetItemText(takasTeklifAlanList,row,1,"ID: "..id,false,false)
            guiGridListSetItemText(takasTeklifAlanList,row,2,"Model: "..model,false,false)
        else
            local row = guiGridListAddRow(takasTeklifGonderenList)
            local model = aracmodel[tonumber(aracid)]
            guiGridListSetItemText(takasTeklifGonderenList,row,1,"ID: "..id,false,false)
            guiGridListSetItemText(takasTeklifGonderenList,row,2,"Model: "..model,false,false)
        end
    elseif tostring(ne) == "para" then
        if tostring(kim) == "Alan" then
            local row = guiGridListAddRow(takasTeklifAlanList)
            guiGridListSetItemText(takasTeklifAlanList,row,1,"Para",false,false)
            guiGridListSetItemText(takasTeklifAlanList,row,2,"Miktar: "..aracid,false,false)
        else
            local row = guiGridListAddRow(takasTeklifGonderenList)
            guiGridListSetItemText(takasTeklifGonderenList,row,1,"Para",false,false)
            guiGridListSetItemText(takasTeklifGonderenList,row,2,"Miktar: "..aracid,false,false)
        end
    elseif tostring(ne) == "mj" then
        if tostring(kim) == "Alan" then
            local row = guiGridListAddRow(takasTeklifAlanList)
            guiGridListSetItemText(takasTeklifAlanList,row,1,"MJ",false,false)
            guiGridListSetItemText(takasTeklifAlanList,row,2,"Miktar: "..aracid,false,false)
        else
            local row = guiGridListAddRow(takasTeklifGonderenList)
            guiGridListSetItemText(takasTeklifGonderenList,row,1,"MJ",false,false)
            guiGridListSetItemText(takasTeklifGonderenList,row,2,"Miktar: "..aracid,false,false)
        end
    end
end)

local prevX, prevY, prevZ = 0
function calculateDistance()
    local vehicle = getPedOccupiedVehicle(localPlayer)
    if not vehicle or isElementFrozen(vehicle) or not isControlEnabled("forwards") then
        return
    end
    local x,y,z = getElementPosition(vehicle)
    if prevX ~= 0 then
        local distanceSinceLast = ((x-prevX)^2 + (y-prevY)^2 + (z-prevZ)^2)^(0.5)
        if distanceSinceLast < 1000 then
            print(getElementData(vehicle,"MG-AracPanel-KM"))
            local total = tonumber(getElementData(vehicle,"MG-AracPanel-KM")) or 0
            setElementData(vehicle,"MG-AracPanel-KM",total+distanceSinceLast)
        end
    end
    prevX = x
    prevY = y
    prevZ = z
end
setTimer(calculateDistance,1000,0)
