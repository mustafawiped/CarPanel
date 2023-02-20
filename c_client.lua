local satinalinacak
local font = guiCreateFont("files/ekfont.ttf",11)

-- Ana Panel
mainwindow = guiCreateWindow(601, 372, 727, 339, "Araç Panel", false)
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
mainAcikArttirmayaEkleBtn = guiCreateButton(535, 176, 167, 48, "Açık Arttırmaya Ekle", false, mainwindow)
guiSetFont(mainAcikArttirmayaEkleBtn,font)
mainSunucuyaSatBtn = guiCreateButton(358, 240, 167, 48, "Aracı Sunucuya Sat\n(Değerinin %50 'sine)", false, mainwindow)
guiSetFont(mainSunucuyaSatBtn,font)
mainAraciTakasEtBtn = guiCreateButton(535, 240, 167, 48, "Aracı Takas Et", false, mainwindow)
guiSetFont(mainAraciTakasEtBtn,font)
mainInfoLbl = guiCreateLabel(460, 306, 139, 13, "MADDE GAMING | Copyright 2023", false, mainwindow)
guiSetFont(mainInfoLbl, "default-small")
mainKapatBtn = guiCreateButton(703, 0, 23, 20, "X", false, mainwindow)    

-- Araç Bilgi ve Satış Paneli
bilgiwindow = guiCreateWindow(747, 335, 410, 440, "Araç Bilgi Panel", false)
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
fiyatwindow = guiCreateWindow(803, 438, 317, 168, "Aracını ne kadara satmak istersin?", false)
guiWindowSetSizable(fiyatwindow, false)
guiSetVisible(fiyatwindow,false)
   
fiyatMiktarTxt = guiCreateEdit(37, 50, 238, 36, "Lütfen fiyat giriniz.", false, fiyatwindow)
guiSetFont(fiyatMiktarTxt,font)
fiyatGeriBtn = guiCreateButton(20, 101, 132, 43, "Geri", false, fiyatwindow)
guiSetFont(fiyatGeriBtn,font)
fiyatSatisaCikarBtn = guiCreateButton(162, 101, 132, 43, "Satışa Çıkar", false, fiyatwindow)   
guiSetFont(fiyatSatisaCikarBtn,font)

-- Takas Panel
takaswindow = guiCreateWindow(699, 273, 525, 576, "Takas Panel", false)
guiWindowSetSizable(takaswindow, false)
guiSetVisible(takaswindow,false)

takasKapatBtn = guiCreateButton(500, 0, 24, 20, "X", false, takaswindow)   
takasAracList = guiCreateGridList(12, 29, 245, 218, false, takaswindow)
guiGridListAddColumn(takasAracList, "Araç ID", 0.2)
guiGridListAddColumn(takasAracList, "Araç Modeli", 0.7)
takasCizgiLbl = guiCreateLabel(0, 257, 521, 15, "⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻", false, takaswindow)
takasAracEkleBtn = guiCreateButton(301, 29, 191, 46, "Araç Ekle", false, takaswindow)
guiSetFont(takasAracEkleBtn,font)
takasAracKaldirBtn = guiCreateButton(301, 85, 191, 46, "Aracı Kaldır", false, takaswindow)
guiSetFont(takasAracKaldirBtn,font)
takasOyuncuList = guiCreateGridList(10, 280, 245, 211, false, takaswindow)
guiGridListAddColumn(takasOyuncuList, "Oyuncu Adları", 0.9)
takasEklenenlerList = guiCreateGridList(272, 280, 243, 211, false, takaswindow)
guiGridListAddColumn(takasEklenenlerList, "Eklenen Ürün", 0.5)
guiGridListAddColumn(takasEklenenlerList, "Miktarı", 0.4)
takasParaEkleBtn = guiCreateButton(301, 141, 191, 46, "Para Ekle", false, takaswindow)
guiSetFont(takasParaEkleBtn,font)
takasMJEkleBtn = guiCreateButton(301, 197, 191, 46, "MJ Ekle", false, takaswindow)
guiSetFont(takasMJEkleBtn,font)
takasOyuncuAramaTxt = guiCreateEdit(30, 519, 187, 34, "Oyuncu Adı Arayabilirsin.", false, takaswindow)
guiSetFont(takasOyuncuAramaTxt,font)
takasTeklifGonderBtn = guiCreateButton(301, 510, 191, 46, "Takas Teklifi Gönder", false, takaswindow)
guiSetFont(takasTeklifGonderBtn,font)

--Kasko Panel
kaskowindow = guiCreateWindow(722, 381, 466, 338, "Madde Gaming | Araç Kasko Sistemi", false)
guiWindowSetSizable(kaskowindow, false)
guiSetVisible(kaskowindow,false)

kaskoList = guiCreateGridList(9, 25, 447, 177, false, kaskowindow)
guiGridListAddColumn(kaskoList, "Araç ID", 0.3)
guiGridListAddColumn(kaskoList, "Araç Markası", 0.3)
guiGridListAddColumn(kaskoList, "Araç Kasko Durumu", 0.3)
kaskoInfoLbl = guiCreateLabel(84, 206, 306, 38, " Aracınızın Markasına göre kasko fiyatı değişmektedir.\nKasko her ayın 25 'inde yenilenmelidir yoksa süre biter.", false, kaskowindow)
kaskoIadeBtn = guiCreateButton(36, 277, 120, 44, "Para İadesi", false, kaskowindow)
kaskoYenileBtn = guiCreateButton(166, 277, 120, 44, "Kaskoyu Yenile", false, kaskowindow)
kaskoYaptirBtn = guiCreateButton(296, 277, 120, 44, "Kasko Yaptır", false, kaskowindow)
kaskoSonOdemeTarihiLbl = guiCreateLabel(26, 246, 215, 21, "Son Ödeme Tarihi = (Araç Seçiniz...)", false, kaskowindow)
kaskoAylikFiyatLbl = guiCreateLabel(246, 246, 210, 21, "Aylık Kasko Fiyatı = (Araç Seçiniz...)", false, kaskowindow)    

-- KODLAR -- 

bindKey("F4","down",function()
    if guiGetVisible(takaswindow) then
        guiSetVisible(takaswindow,false)
    elseif guiGetVisible(fiyatwindow) then
        guiSetVisible(fiyatwindow,false)
    elseif guiGetVisible(bilgiwindow) then
        guiSetVisible(bilgiwindow,false)
    elseif guiGetVisible(kaskowindow) then
        guiSetVisible(kaskowindow,false)
    end
    if guiGetVisible(mainwindow) then
        guiSetVisible(mainwindow,false)
        showCursor(false)
    else
        triggerServerEvent("MG-CarPanel:AraclariListele",localPlayer)
    end
end)

addEventHandler("onClientGUIClick",getRootElement(),function()
    if source == mainAracBilgisiBtn then
        guiSetVisible(mainwindow,false)
        guiSetText(bilgiSatinAlBtn,"Paneli Kapat")
        guiSetText(bilgiGeriBtn,"Geri")
        guiSetVisible(bilgiwindow,true)
    elseif source == mainAraciSatisaCikar then
        guiSetVisible(mainwindow,false)
        guiSetVisible(fiyatwindow,true)
    elseif source == mainAraciTakasEtBtn then
        guiSetVisible(mainwindow,false)
        guiSetVisible(takaswindow,true)
    elseif source == mainKapatBtn then
        guiSetVisible(mainwindow,false)
        showCursor(false)
    elseif source == takasKapatBtn then
        guiSetVisible(takaswindow,false)
        showCursor(false)
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
                triggerServerEvent("MG-CarPanel:AraciSatinAl1",localPlayer,satinalinacak,fiyati) -- sıfır araba alırken yapılacaklar
            else
                -- başka bir oyuncunun arabasını satın alınca yazılacak kodlar
            end
        end
    end
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
    guiSetText(bilgiOncekiFiyatiLbl,"● Araç Önceki Fiyatı = Yok, Araç Sıfır.")
    guiSetText(bilgiAracIDlbl,"● Araç ID 'si = Yok, Araç Sisteme kayıtlı değil.")
    guiSetVisible(bilgiwindow,true)
    showCursor(true)
end

addEvent("MG-CarPanel:TekrarClienteGonder",true)
addEventHandler("MG-CarPanel:TekrarClienteGonder",getRootElement(),function(veriler)
    guiGridListClear(mainAracList)
    for i,v in pairs(veriler) do
        local modeli = aracmodel[tonumber(v["aracid"])]
        local row = guiGridListAddRow(mainAracList)
        guiGridListSetItemText(mainAracList,row,1,v["id"],false,false)
        guiGridListSetItemText(mainAracList,row,2,modeli,false,false)
        guiGridListSetItemText(mainAracList,row,3,v["kaskodurum"],false,false)
    end
    guiSetVisible(mainwindow,true)
    showCursor(true)
end)


-- Geliştirici Notları

--    Şimdi yapman gerekenler

--    Arabayı indirme kaldırma ve vaktin kalırsa araç bilgilerini kayıt olaylarını hallet.
--
--    sonra araç bilgisi ve aracı yanına çekme olayını yap.
--
--    sonra aracı satışa çıkarma ve başka bir oyuncunun satın alma olayını yap.
--    
--    Açık arttırmaya ekle kısmı basit ztn
--
--    aracı sunucuya sat kısmı da basit ztn
--
--    Araci Takas et kısmına gelince tüm takas fonksiyonları yaz ve sistem bitti eline sağlık.
