
--------------------------------------------------

-- 1. KATEGORİ TABLOSU
-- CREATE TABLE "kategori" (
--     kategori_id serial primary key,
--     kategori_ismi varchar(50) NOT NULL
-- );

-- 2. ŞUBE TABLOSU
-- CREATE TABLE "sube"(
--     sube_id serial primary key,
--     sube_ismi varchar(50) NOT NULL,
--     sehir varchar(25),
--     adres text
-- );

-- 3. DEPARTMAN TABLOSU
-- CREATE TABLE "departman"(
--     departman_id serial primary key,
--     departman_ismi varchar(50) NOT NULL
-- );


-- 4. TEDARİKÇİ TABLOSU
-- CREATE TABLE "tedarikci"(
--     supplier_id serial primary key,
--     firma_ismi varchar(50) NOT NULL,
--     sehir varchar(25),
--     adres text
-- );


-- 5. DEPO TABLOSU
-- CREATE TABLE "depo"(
--     depo_id serial primary key,
--     depo_ismi varchar(50) NOT NULL,
--     adres text
-- );


-- 6. MÜŞTERİ TABLOSU 
-- CREATE TABLE "musteri" (
--     musteri_id serial primary key,
--     isim varchar(25) NOT NULL,
--     soyisim varchar(25) NOT NULL,
--     iletisim varchar(15) unique
-- );


-- 7. PERSONEL TABLOSU 
-- CREATE TABLE "personel"(
--     personel_id serial primary key,
--     isim varchar(25) NOT NULL,
--     soyisim varchar(25) NOT NULL,
--     iletisim varchar(15) unique,
-- 	   departman_id int references departman(departman_id),
--     maas int check (maas > 22004)
-- );


-- 8. ÜRÜN TABLOSU
-- CREATE TABLE "urun" (
--     urun_id serial primary key,
--     kategori_id int references kategori(kategori_id),
--     urun_ismi varchar(50) NOT NULL,
--     fiyat real not null
-- );


-- 9. SİPARİŞ TABLOSU 
-- CREATE TABLE "orders"(
--     order_id serial primary key,
--     musteri_id int references musteri(musteri_id),
--     sube_id int references sube(sube_id),
--     tarih date default CURRENT_DATE,
--     toplam_tutar real
-- );


-- --- İLİŞKİ VE İŞLEM TABLOLARI ---


-- 10. SİPARİŞ DETAYLARI
-- CREATE TABLE "order_detail"(
--     order_id int references orders(order_id),
--     urun_id int references urun(urun_id),
--     birim_fiyat real,
--     adet int,
--     indirim_orani real,
--     primary key(order_id , urun_id)
-- );


-- 11. ŞUBE STOK (Bulunur İlişkisi)
-- CREATE TABLE "urun_sube_stok"(
--     sube_id int references sube(sube_id),
--     urun_id int references urun(urun_id),
--     sube_stok int default 0,
--     primary key(sube_id, urun_id)
-- );


-- 12. DEPO STOK (saklanır)
-- CREATE TABLE "depo_stok"(
--     depo_id int references depo(depo_id),
--     urun_id int references urun(urun_id),
--     adet int default 0,
--     primary key(depo_id, urun_id)
-- );


-- 13. TEDARİKÇİDEN DEPOYA SEVKİYAT (Temin Eder)
-- CREATE TABLE "tedarik_islem"(
--     islem_id serial primary key,
--     supplier_id int references tedarikci(supplier_id),
--     depo_id int references depo(depo_id),
--     urun_id int references urun(urun_id),
--     adet int,
--     sevkiyat_tarihi date
-- );


-- 14. DEPODAN ŞUBEYE SEVKİYAT (Stok Sağlar)
-- CREATE TABLE "depo_sevk_islem"(
--     sevk_id serial primary key,
--     depo_id int references depo(depo_id),
--     sube_id int references sube(sube_id),
--     urun_id int references urun(urun_id),
--     adet int,
--     sevkiyat_tarihi date
-- );


-- 15. İADE TABLOSU (iade)
-- CREATE TABLE "iade"(
--     iade_id serial primary key,
--     musteri_id int references musteri(musteri_id),
--     order_id int references orders(order_id),
--     urun_id int references urun(urun_id),
--     iade_tarihi date default CURRENT_DATE
-- );



-- 16. PUAN
-- CREATE TABLE "musteri_urun_puan"(
--     rate_id serial primary key,
--     musteri_id int references musteri(musteri_id),
--     urun_id int references urun(urun_id),
--     puan int check (puan between 1 and 5)
-- );


-- 17. PERSONEL ŞUBE GEÇMİŞİ (Çalışır)
-- CREATE TABLE "personel_sube_gecmis"(
--     kayit_id serial primary key,
--     personel_id int references personel(personel_id),
--     sube_id int references sube(sube_id),
--     giris_tarihi date,
--     cikis_tarihi date
-- );




-- KATEGORİ TABLOSUNA VERİ EKLEME
-- insert into kategori(kategori_ismi)
-- VALUES 
-- ('Kaban_mont'),
-- ('Ceket'),
-- ('Kazak_hirka'),
-- ('Sweatshirt'),
-- ('Pantolon'),
-- ('Etek'),
-- ('Elbise'),
-- ('Gomlek'),
-- ('Tshirt'),
-- ('Takim'),
-- ('Corap');



-- ŞUBE TABLOSUNA VERİ EKLEME
-- INSERT INTO sube(sube_ismi,sehir,adres)
-- VALUES
-- ('Piazz_Sube','İstanbul','Cevizli Tugay Yolu Caddesi 69-C 34846 Maltepe/İstanbul'),
-- ('Malatya_Park_Sube','Malatya','İnönü Mahallesi İnönü Caddesi Malatya Park Avm 192 44100 Yeşilyurt/Malatya');



-- DEPARTMAN TABLOSUNA VERİ EKLEME
-- INSERT INTO departman(departman_ismi)
-- VALUES
-- ('Sube_Sorumlusu'),
-- ('Magaza_Gorevlisi'),
-- ('Magaza_Kasa');


-- TEDARİKÇİ TABLOSUNA VERİ EKLEME
-- INSERT INTO tedarikci(firma_ismi,sehir,adres)
-- VALUES
-- ('Firma_A','Ankara','xx mahallesi yy caddesi'),
-- ('Firma_B','Mersin','xx mahallesi yy caddesi'),
-- ('Firma_C','Adana','xx mahallesi yy caddesi'),
-- ('Firma_D','Malatya','xx mahallesi yy caddesi'),
-- ('Firma_E','Adıyaman','xx mahallesi yy caddesi'),
-- ('Firma_F','Gaziantep','xx mahallesi yy caddesi'),
-- ('Firma_G','Bursa','xx mahallesi yy caddesi'),
-- ('Firma_H','Kocaeli','xx mahallesi yy caddesi'),
-- ('Firma_J','İzmir','xx mahallesi yy caddesi'),
-- ('Firma_I','İstanbul','xx mahallesi yy caddesi');


-- DEPO TABLOSUNA VERİ EKLEME
-- INSERT INTO depo(depo_ismi,adres)
-- VALUES
-- ('Depo_A','yy mahallesi xx caddesi'),
-- ('Depo_B','yy mahallesi xx caddesi'),
-- ('Depo_C','yy mahallesi xx caddesi'),
-- ('Depo_D','yy mahallesi xx caddesi'),
-- ('Depo_E','yy mahallesi xx caddesi'),
-- ('Depo_F','yy mahallesi xx caddesi'),
-- ('Depo_G','yy mahallesi xx caddesi'),
-- ('Depo_H','yy mahallesi xx caddesi'),
-- ('Depo_I','yy mahallesi xx caddesi'),
-- ('Depo_J','yy mahallesi xx caddesi');


-- MÜŞTERİ TABLOSUNA VERİ EKLEME
-- INSERT INTO musteri(isim,soyisim,iletisim)
-- VALUES
-- ('Zeynep','Z','01020304001'),
-- ('İrem','İ','01020304002'),
-- ('Elif','E','01020304003'),
-- ('Ayşe','A','01020304004'),
-- ('Deniz','D','01020304005'),
-- ('Eren','E','01020304006'),
-- ('Doğan','D','01020304007'),
-- ('Berk','B','01020304008'),
-- ('Egemen','E','01020304009'),
-- ('Kerem','K','01020304010');


-- PERSONEL TABLOSUNA VERİ EKLEME
-- INSERT INTO personel(isim,soyisim,iletisim,departman_id,maas)
-- VALUES
-- ('İpek','İ','01020304011',1,50000),
-- ('Hande','H','01020304012',1,50000),
-- ('Faruk','F','01020304013',2,40000),
-- ('Oğuz','O','01020304014',2,40000),
-- ('Ali','A','01020304015',2,40000),
-- ('Efe','E','01020304016',2,40000),
-- ('Mete','M','01020304017',2,40000),
-- ('Burak','B','01020304018',2,40000),
-- ('Korkut','K','01020304019',2,40000),
-- ('Sinan','S','01020304020',2,40000);


-- ÜRÜN TABLOSUNA VERİ EKLEME
-- INSERT INTO urun(urun_ismi,kategori_id,fiyat)
-- VALUES
-- ('su_gecirmez_ince_mont',1,1999.99),
-- ('cepli_crop_mont',1,1599.99),
-- ('oversize_blazer_ceket',2,1999.99),
-- ('oversize_suni_deri_ceket',2,2299.99),
-- ('relax_fit_triko_kazak',3,499.99),
-- ('bisiklet_yaka_dugmeli_hirka',3,999.99),
-- ('boxy_fit_basic_sweatshirt',4,799.99),
-- ('regular_fit_baskili_sweatshirt',4,799.99),
-- ('nineties_wide_leg_high_waist_pantolon',5,1299.99),
-- ('relax_fit_duz_paca_pantolon',5,1699.99),
-- ('fashion_fit_uzun_boy_etek',6,999.99),
-- ('normal_waist_mini_suet_etek',6,999.99),
-- ('bisiklet_yaka_ribona_uzun_kollu_elbise',7,1399.99),
-- ('tailored_fit_kolsuz_mini_elbise',7,1599.99),
-- ('oversize_basic_oxford_gomlek',8,699.99),
-- ('regular_fit_kareli_flanel_gomlek',8,999.99),
-- ('halter_yaka_ribona_kisakollu_tshirt',9,599.99),
-- ('Relax_fit_kisakollu_tshirt',9,799.99),
-- ('regular_fit_takim_elbise',10,2499.99),
-- ('tailored_fit_takim_elbise',10,2499.99),
-- ('yedili_pamuk_corap',11,349.99),
-- ('besli_pamuk_corap',11,249.99);



-- SİPARİŞ TABLOSUNA VERİ EKLEME
-- INSERT INTO orders(musteri_id,sube_id,tarih,toplam_tutar)
-- VALUES
-- (10,1,'2025-01-01',2249.99),
-- (9,1,'2025-02-01',1949.99),
-- (8,1,'2025-03-01',4449.99),
-- (7,1,'2025-04-01',4649.99),
-- (6,1,'2025-05-01',1199.99),
-- (5,2,'2025-06-01',1599.99),
-- (4,2,'2025-07-01',1799.99),
-- (3,2,'2025-08-01',1499.99),
-- (2,2,'2025-09-01',2799.99),
-- (1,2,'2025-10-01',5098.96);


-- SİPARİŞ DETAYLARI TABLOSUNA VERİ EKLEME
-- INSERT INTO order_detail(order_id,urun_id,birim_fiyat,adet,indirim_orani)
-- VALUES
-- (1,1,1999.99,1,0.0),
-- (1,22,2499.99,1,0.0),
-- (2,2,1599.99,1,0.0),
-- (2,21,349.99,1,0.0),
-- (3,3,1999.99,1,0.0),
-- (3,20,2499.99,1,0.0),
-- (4,4,2299.99,1,0.0),
-- (4,19,2499.99,1,0.0),
-- (5,5,499.99,1,0.0),
-- (5,18,799.99,1,0.0),
-- (6,6,999.99,1,0.0),
-- (6,17,599.99,1,0.0),
-- (7,7,799.99,1,0.0),
-- (7,16,999.99,1,0.0),
-- (8,8,799.99,1,0.0),
-- (8,15,699.99,1,0.0),
-- (9,9,1299.99,1,0.0),
-- (9,14,1599.99,1,0.0),
-- (10,10,1699.99,1,0.0),
-- (10,11,999.99,1,0.0),
-- (10,12,999.99,1,0.0),
-- (10,13,1399.99,1,0.0);


-- ŞUBE STOK TABLOSUNA VERİ EKLEME
-- INSERT INTO urun_sube_stok(sube_id,urun_id,sube_stok)
-- VALUES
-- (1,1,1000),
-- (1,2,1000),
-- (1,3,1000),
-- (1,4,1000),
-- (1,5,1000),
-- (1,6,1000),
-- (1,7,1000),
-- (1,8,1000),
-- (1,9,1000),
-- (1,10,1000),
-- (1,11,1000),
-- (1,12,1000),
-- (1,13,1000),
-- (1,14,1000),
-- (1,15,1000),
-- (1,16,1000),
-- (1,17,1000),
-- (1,18,1000),
-- (1,19,1000),
-- (1,20,1000),
-- (1,21,1000),
-- (1,22,1000);


-- DEPO STOK TABLOSUNA VERİ EKLEME
-- INSERT INTO depo_stok(depo_id,urun_id,adet)
-- VALUES
-- (1,1,10000),
-- (2,2,10000),
-- (3,3,10000),
-- (4,4,10000),
-- (5,5,10000),
-- (6,6,10000),
-- (7,7,10000),
-- (8,8,10000),
-- (9,9,10000),
-- (10,10,10000);


-- TEDARİKÇİDEN DEPOYA SEVK TABLOSUNA VERİ EKLEME
-- INSERT INTO tedarik_islem(supplier_id,depo_id,urun_id,adet,sevkiyat_tarihi)
-- VALUES
-- (1,1,1,2000,'2025-01-01'),
-- (2,2,2,2000,'2025-02-01'),
-- (3,3,3,2000,'2025-03-01'),
-- (4,4,4,2000,'2025-04-01'),
-- (5,5,5,2000,'2025-05-01'),
-- (6,6,6,2000,'2025-06-01'),
-- (7,7,7,2000,'2025-07-01'),
-- (8,8,8,2000,'2025-08-01'),
-- (9,9,9,2000,'2025-09-01'),
-- (10,10,10,2000,'2025-10-01');


-- DEPODAN ŞUBEYE SEVK TABLOSUNA VERİ EKLEME
-- INSERT INTO depo_sevk_islem(depo_id,sube_id,urun_id,adet,sevkiyat_tarihi)
-- VALUES
-- (1,1,1,1000,'2025-01-10'),
-- (2,1,2,1000,'2025-02-10'),
-- (3,1,3,1000,'2025-03-10'),
-- (4,1,4,1000,'2025-04-10'),
-- (5,1,5,1000,'2025-05-10'),
-- (6,2,6,1000,'2025-06-10'),
-- (7,2,7,1000,'2025-07-10'),
-- (8,2,8,1000,'2025-08-10'),
-- (9,2,9,1000,'2025-09-10'),
-- (10,2,10,1000,'2025-10-10');


-- İADE TABLOSUNE VERİ EKLEME
-- INSERT INTO iade(musteri_id,order_id,urun_id,iade_tarihi)
-- VALUES
-- (10,1,22,'2025-01-11'),
-- (9,2,21,'2025-02-11'),
-- (8,3,20,'2025-03-11'),
-- (7,4,19,'2025-04-11'),
-- (6,5,18,'2025-05-11'),
-- (5,6,17,'2025-06-11'),
-- (4,7,16,'2025-07-11'),
-- (3,8,15,'2025-08-11'),
-- (2,9,14,'2025-09-11'),
-- (1,10,13,'2025-10-11');


-- PUAN TABLOSUNA VERİ EKLEME
-- INSERT INTO musteri_urun_puan(musteri_id,urun_id,puan)
-- VALUES
-- (10,1,3),
-- (9,2,3),
-- (8,3,4),
-- (7,4,5),
-- (6,5,1),
-- (5,6,1),
-- (4,7,3),
-- (3,8,2),
-- (2,9,5),
-- (1,10,5);


-- PERSONEL ŞUBE TABLOSUNE VERİ EKLEME
-- INSERT INTO personel_sube_gecmis(personel_id,sube_id,giris_tarihi)
-- VALUES
-- (1,1,'2025-01-01'),
-- (2,2,'2025-01-01'),
-- (3,1,'2025-01-02'),
-- (4,2,'2025-01-02'),
-- (5,1,'2025-01-02'),
-- (6,2,'2025-01-02'),
-- (7,1,'2025-01-02'),
-- (8,2,'2025-01-02'),
-- (9,1,'2025-01-02'),
-- (10,2,'2025-01-02');

-- HAFTA 10 RAPOR
-- SELECT * FROM personel;


-- HAFTA 11 RAPOR

-- sorgular için tekrardan veri ekleme


-- musteri'ye yeni veriler eklendi
-- INSERT INTO musteri(isim,soyisim,iletisim)
-- VALUES
-- ('Ceren','C','01020304011'),
-- ('Cansu','Ca','01020304012'),
-- ('Kardelen','K','01020304013'),
-- ('Kübra','Kü','01020304014'),
-- ('Tuana','T','01020304015'),
-- ('Tuğba','Tuğ','01020304016'),
-- ('Türkan','Tü','01020304017'),
-- ('Yasemin','Yas','01020304018'),
-- ('Yağmur','Yağ','01020304019'),
-- ('Selin','Sel','01020304020');


-- orders'a yeni veriler eklendi

-- INSERT INTO orders(musteri_id,sube_id,tarih,toplam_tutar)
-- VALUES
-- ( 11, 2, '2025/11/17',2499.99),
-- ( 12, 2, '2025/11/17',2999.98),
-- ( 13, 2, '2025/11/17',2499.98),
-- ( 14, 2, '2025/11/17',1299.97),
-- ( 15, 2, '2025/11/17',249.99),
-- ( 16, 2, '2025/11/17',1599.99),
-- ( 17, 2, '2025/11/17',999.99),
-- ( 18, 2, '2025/11/17',1599.99),
-- ( 19, 1, '2025/11/17',4899.96),
-- ( 20, 1, '2025/11/17',249.99);

-- order_detail'e yeni veriler eklendi

-- INSERT INTO order_detail(order_id,urun_id,birim_fiyat,adet,indirim_orani)
-- VALUES
-- (11,22,249.99,10,0.0),
-- (12,3,1999.99,1,0.0),
-- (12,12,999.99,1,0.0),
-- (13,1,1999.99,1,0.0),
-- (13,5,499.99,1,0.0),
-- (14,17,599.99,1,0.0),
-- (14,21,349.99,2,0.0),
-- (15,22,249.99,1,0.0),
-- (16,2,1599.99,1,0.0),
-- (17,12,999.99,1,0.0),
-- (18,14,1599.99,1,0.0),
-- (19,20,2499.99,1,0.0),
-- (19,18,799.99,3,0.0),
-- (20,22,249.99,1,0.0);


-- iade'ye yeni veriler eklendi


-- INSERT INTO iade(musteri_id,order_id,urun_id,iade_tarihi)
-- VALUES
-- (19,19,18,'2025-11-28'),
-- (19,19,18,'2025-11-28'),
-- (19,19,18,'2025-11-28');


-- müşteri_ürün_puan'a yeni veriler eklendi


-- INSERT INTO musteri_urun_puan(musteri_id,urun_id,puan)
-- VALUES
-- (11,22,4),
-- (12,3,3),
-- (12,12,5),
-- (13,1,5),
-- (13,5,2),
-- (14,17,5),
-- (14,21,4),
-- (15,22,2),
-- (16,2,5),
-- (17,12,4),
-- (18,14,3),
-- (19,20,5),
-- (19,18,1),
-- (20,22,3);



-- urun_sube_stok'a yeni veriler eklendi

-- INSERT INTO urun_sube_stok(sube_id,urun_id,sube_stok)
-- VALUES
-- (2,1,1000),
-- (2,2,1000),
-- (2,3,1000),
-- (2,4,1000),
-- (2,5,1000),
-- (2,6,1000),
-- (2,7,1000),
-- (2,8,1000),
-- (2,9,1000),
-- (2,10,1000),
-- (2,11,1000),
-- (2,12,1000),
-- (2,13,1000),
-- (2,14,1000),
-- (2,15,1000),
-- (2,16,1000),
-- (2,17,1000),
-- (2,18,1000),
-- (2,19,1000),
-- (2,20,1000),
-- (2,21,1000),
-- (2,22,1000);


---------------------------------------------

-- HAFTA 11 8 QUERY

-- 1) TEK SEFERDE YAPILMIŞ EN YÜKSEK TUTARLI ALIŞVERİŞE AİT ÜRÜNLERİN BİLGİLERİ
-- 2) HER ŞUBEDE YAPILAN TOPLAM SATIŞ MİKTARI
-- 3) PUAN ORTALAMASININ ÜSTÜNDE PUANA SAHİP ÜRÜNLERİN BİLGİLERİ
-- 4) EN ÇOK SATILAN ÜRÜNE AİT BİLGİLER
-- 5) EN ÇOK SİPARİŞİN YAPILDIĞI ŞUBENİN BİLGİLERİ
-- 6) EN ÇOK İADE EDİLEN ÜRÜNE AİT BİLGİLER
-- 7) EN YÜKSEK PUAN ORTALAMASINA SAHİP ÜRÜNE AİT BİLGİLER
-- 8) HER ŞUBEDE EN AZ STOĞA SAHİP ÜRÜNLERİN BİLGİLERİ

---------------------------------------------

-- 1) TEK SEFERDE YAPILMIŞ EN YÜKSEK TUTARLI ALIŞVERİŞE AİT ÜRÜNLERİN BİLGİLERİ
-- orders - order_detail

-- 1. adım en yüksek tutarlı alışverişin order_id sini bulmak


-- SELECT order_id
-- FROM orders
-- WHERE toplam_tutar = 
-- (
-- 	Select MAX(toplam_tutar)
-- 	from orders
-- );


-- 2. adım bulunan order_id'yi order_detail tablosunda kullanarak hangi ürünleri içerdiğini bulmak (birden fazla ürün olma ihtimali için IN kullanılacaktır)

-- SELECT urun_id
-- FROM order_detail
-- WHERE order_id = 
-- (
-- 	SELECT order_id
-- 	FROM orders
-- 	WHERE toplam_tutar = 
-- 	(
-- 		Select MAX(toplam_tutar)
-- 		from orders
-- 	)
-- );

-- 3. ve son adım bulunan her bir urun_id değer(ler)i için ürün ismi kategorisi ve fiyat bilgisini göstermek FİNAL HAL

-- -- 1
-- SELECT *
-- FROM urun
-- WHERE urun_id IN 
-- (
-- 	SELECT urun_id
-- 	FROM order_detail
-- 	WHERE order_id = 
-- 	(
-- 		SELECT order_id
-- 		FROM orders
-- 		WHERE toplam_tutar = 
-- 		(
-- 			Select MAX(toplam_tutar)
-- 			from orders
-- 		)
-- 	)
-- );

-- 2) HER ŞUBEDE YAPILAN TOPLAM SATIŞ MİKTARI
-- orders - sube

-- 1. adım orders tablosundaki siparişleri sube_id ye göre gruplamak

-- SELECT sube_id , SUM(toplam_tutar) as "Şubeye ait toplam satış"
-- FROM orders
-- GROUP BY sube_id
-- ORDER BY sube_id ASC;

-- 2. adım ilk aşamada ortaya çıkan tabloya şubenin bilgilerini eklemek (JOIN) FİNAL HAL

-- SELECT sube.sube_id , sube.sube_ismi , SUM(orders.toplam_tutar) as "Şubeye ait toplam satış"
-- FROM orders
-- JOIN sube ON orders.sube_id = sube.sube_id
-- GROUP BY sube.sube_id, sube.sube_ismi
-- ORDER BY sube.sube_id ASC;

-- 3) PUAN ORTALAMASININ ÜSTÜNDE PUANA SAHİP ÜRÜNLERİN BİLGİLERİ
-- musteri_urun_puan - urun

-- 1.adım musteri_urun_puan tablosunda tüm ürünlerin puan ortalamasını hesaplamak daha sonra he ürünü kendi içinde gruplayıp ürün ort > genel ort olanları yazdırmak

-- genel ürün ortalaması
-- SELECT AVG(puan)
-- FROM musteri_urun_puan;

-- ürün başı puan ortalaması genel ürün puan ortalasından yüksek olan ürünler
-- SELECT urun_id , AVG(puan)
-- FROM musteri_urun_puan
-- GROUP BY urun_id
-- HAVING AVG(puan) > 
-- (
--     SELECT AVG(puan)
--     FROM musteri_urun_puan
-- )
-- ORDER BY urun_id ASC;



--ürünlerin bilgileri yazma FİNAL HAL

-- SELECT *
-- FROM urun
-- WHERE urun_id IN
-- (
-- 	SELECT urun_id
-- 	FROM musteri_urun_puan
-- 	GROUP BY urun_id
-- 	HAVING AVG(puan) > 
-- 	(
-- 	    SELECT AVG(puan)
-- 	    FROM musteri_urun_puan
-- 	)
-- 	ORDER BY urun_id ASC
-- );

-- 4) EN ÇOK SATILAN ÜRÜNE AİT BİLGİLER
-- order_detail - urun

-- order_detail de adet bilgisi olduğu için toplam adet'i max olan satırın urun_id değerini alıp urun tablosunda kullanacağız

-- en çok satılan ürünün idsi ve toplam satış adet bilgileri


-- SELECT urun_id , SUM(adet) as toplam_adet
-- FROM order_detail
-- GROUP BY urun_id
-- ORDER BY toplam_adet DESC
-- LIMIT 1;

-- en çok satılan ürünün idsi

-- SELECT urun_id
-- FROM order_detail
-- GROUP BY urun_id
-- ORDER BY SUM(adet) DESC
-- LIMIT 1;

-- en çok satılan ürünün bilgileri FİNAL HAL

-- SELECT *
-- FROM urun
-- WHERE urun_id = (
-- 	SELECT urun_id
-- 	FROM order_detail
-- 	GROUP BY urun_id
-- 	ORDER BY SUM(adet) DESC
	
-- );

-- 5) EN ÇOK SİPARİŞİN YAPILDIĞI ŞUBENİN BİLGİLERİ
-- orders - sube

-- en çok siparişin yapıldığı şubeyi sayarak buluruz fazla olanın id sini alırız FİNAL HAL

-- SELECT *
-- FROM sube
-- WHERE sube_id = (
--     SELECT sube_id
--     FROM orders
--     GROUP BY sube_id
--     ORDER BY COUNT(order_id) DESC 
--     LIMIT 1
-- );

-- 6) EN ÇOK İADE EDİLEN ÜRÜNE AİT BİLGİLER
-- iade - urun



-- iade edilen ürünün id sini ürün tablosunda kullanarak bilgileri yazıyoruz FİNAL HAL



-- SELECT *
-- FROM urun
-- WHERE urun_id = (
-- 	SELECT urun_id
-- 	FROM iade
-- 	GROUP BY urun_id
-- 	ORDER BY COUNT(urun_id) DESC
-- 	LIMIT 1
-- );

-- 7) EN YÜKSEK PUAN ORTALAMASINA SAHİP ÜRÜNE AİT BİLGİLER
-- musteri_urun_puan - urun

-- En yüksek puana sahip ürünlerin bilgileri FİNAL HAL

-- SELECT urun.urun_id , urun.urun_ismi ,AVG(musteri_urun_puan.puan) as ortalama_puan
-- FROM urun
-- JOIN musteri_urun_puan ON urun.urun_id = musteri_urun_puan.urun_id
-- GROUP BY urun.urun_id, urun.urun_ismi
-- HAVING AVG(musteri_urun_puan.puan) = (
--     SELECT AVG(puan) 
--     FROM musteri_urun_puan
--     GROUP BY urun_id
--     ORDER BY AVG(puan) DESC
-- 	LIMIT 1
-- );

-- 8) 1.ŞUBEDE EN AZ STOĞA SAHİP ÜRÜNÜN BİLGİLERİ

-- FİNAL HAL

-- SELECT urun_sube_stok.sube_id , urun.urun_ismi , urun_sube_stok.sube_stok
-- FROM urun
-- JOIN urun_sube_stok ON urun.urun_id = urun_sube_stok.urun_id
-- WHERE urun_sube_stok.sube_id = 1
-- ORDER BY urun_sube_stok.sube_stok ASC
-- LIMIT 1;

-- ******************************************************************************************************************************************************

-- HAFTA 12 RAPOR BAŞLANGICI

-- ON DELETE CASCADE ÖRNEĞİ 1

-- ÖNCE order_detail tablosundaki order_id 
--foreign key kısıtlamasını kaldırıyoruz

-- ALTER TABLE order_detail
-- DROP CONSTRAINT IF EXISTS order_detail_order_id_fkey;


-- SONRA order_detail tablosuna order_id foreign key kısıtlamasını 
-- ON DELETE CASCADE olacak şekilde tekrar ekliyoruz

-- ALTER TABLE order_detail
-- ADD CONSTRAINT order_detail_order_id_fkey
-- FOREIGN KEY (order_id)
-- REFERENCES orders(order_id)
-- ON DELETE CASCADE;

-- ORDERS TABLOSUNDAKİ ORDER_ID Sİ ÖRNEK OLARAK 3 OLAN SİPARİŞ SİLİNİNCE ORDER_DETAIL TABLOSUNDA ORDER_ID Sİ 3 OLANLAR SİLİNECEKTİR

-- **************************************************

-- ÖNCE orders tablosundaki sube_id 
--foreign key kısıtlamasını kaldırıyoruz

-- ALTER TABLE orders
-- DROP CONSTRAINT IF EXISTS orders_sube_id_fkey;

-- SONRA orders tablosuna sube_id foreign key kısıtlamasını 
--ON DELETE SET NULL olacak şekilde tekrar ekliyoruz

-- ALTER TABLE orders
-- ADD CONSTRAINT orders_sube_id_fkey
-- FOREIGN KEY (sube_id)
-- REFERENCES sube(sube_id)
-- ON DELETE SET NULL;

-- SUBE TABLOSUNDA SUBE_ID Sİ 1 OLAN SATIR SİLİNİNCE ORDERS TABLOSUNDA SUBE_ID Sİ 1 OLAN SATIRLARI NULL YAPACAK

-- **************************************************

-- müşterilerin isim ve soyisim kolonlarını birleştiren fonksiyon FİNAL HAL

-- CREATE OR REPLACE FUNCTION public.bilgi_getir(fun_musteri_id INT)
-- RETURNS VARCHAR
-- LANGUAGE plpgsql
-- AS $$
-- DECLARE
-- 	bilgi VARCHAR;
-- 	musteri_kontrol BOOLEAN;
-- BEGIN
-- 	-- 1. ADIM MÜŞTERİ VAR MI KONTROL EDİYORUZ
-- 	SELECT EXISTS 
-- 	(
-- 		SELECT musteri_id
-- 		FROM musteri
-- 		WHERE musteri_id = fun_musteri_id
-- 	) INTO musteri_kontrol;

-- 	-- EĞER YOKSA HATA MESAJI YAZIYORUZ
-- 	IF musteri_kontrol IS FALSE THEN
-- 		RAISE EXCEPTION '% NUMARALI MÜŞTERİ YOK',fun_musteri_id;
-- 	END IF;
-- 	-- MÜŞTERİ İSİM VE SOYİSİM BİLGİLERİNİ BİRLEŞTİRİP BİLGİ DEĞİŞKENİNE ATAYIP DÖNDÜRÜYORUZ
-- 	SELECT isim || ' ' || soyisim INTO bilgi
-- 	FROM musteri
-- 	WHERE musteri_id = fun_musteri_id;
	
-- 	RETURN bilgi;
-- END;
-- $$;

-- SELECT bilgi_getir(11);

-- **************************************************

-- hangi şubeden kaç alışveriş yapıldığını sayan fonksiyon FİNAL HAL

-- CREATE OR REPLACE FUNCTION public.sube_siparis_sayisi_getir(fun_sube_id INT)
-- RETURNS INT
-- LANGUAGE plpgsql
-- AS $$
-- DECLARE
-- 	siparis_adeti INT;
-- 	sube_kontrol BOOLEAN;
-- BEGIN
-- 	-- 1. ADIM ŞUBE VAR MI DİYE KONTROL EDİYORUZ
-- 	SELECT EXISTS
-- 	(
-- 		SELECT sube_id 
-- 		FROM sube
-- 		WHERE sube_id = fun_sube_id
-- 	) INTO sube_kontrol;

-- 	-- 2. ADIM EĞER SUBE YOK İSE HATA MESAJI YOLLUYORUZ
-- 	IF sube_kontrol IS FALSE THEN 
-- 		RAISE EXCEPTION '% ID NUMARALI BİR ŞUBE YOK',fun_sube_id;
-- 	END IF;

-- 	-- 3. ADIM ŞUBE VAR İSE O ŞUBEYE AİT SİPARİŞ SAYISINI DÖNDÜREN İŞLEMİ YAPIYORUZ
-- 	SELECT COUNT(sube_id) INTO siparis_adeti
-- 	FROM orders
-- 	WHERE sube_id = fun_sube_id;
-- 	RETURN siparis_adeti;
-- END;
-- $$;

-- ÖRNEKLERRRRRRRRRRRRRRRRRRRRRR

-- SELECT sube_siparis_sayisi_getir(2);
-- çıktı = 13
-- SELECT sube_siparis_sayisi_getir(5);
-- çıktı = ERROR:  5 ID NUMARALI BİR ŞUBE YOK

-- **************************************************

-- order_detail order_id FKEY ON DELETE CASCADE ÖRNEĞİ

-- INSERT INTO orders(musteri_id,sube_id,toplam_tutar)
-- VALUES
-- (20,2,170000);



-- INSERT INTO order_detail(order_id,urun_id,adet)
-- VALUES
-- (23,1,99);

-- ORDERS TABLOSUNDAKİ ORDER_ID Sİ ÖRNEK OLARAK 3 OLAN SİPARİŞ SİLİNİNCE ORDER_DETAIL TABLOSUNDA ORDER_ID Sİ 3 OLANLAR SİLİNECEKTİR

-- DELETE FROM orders
-- WHERE order_id = 21; // burda orders tablosundaki order_id serial arttığı için önce orders tablosundan yeni gelen siparişin order_id değerini bulup ona göre WHERE sube_id = x yapıcaz

-- *************************

-- orders sube_id FKEY ON DELETE SET NULL ÖRNEĞİ

-- *************************

-- INSERT INTO sube(sube_ismi,adres,sehir)
-- VALUES
-- ('deneme şube','on delete mahallesi set null caddesi','Ankara');

-- INSERT INTO orders(musteri_id,sube_id,toplam_tutar)
-- VALUES
-- (20,4,790000);

-- DELETE FROM sube
-- WHERE sube_id = 3; // burda sube tablosundaki sube_id serial arttığı için önce sube tablosundan sube_id nin kaç olduğuna bakıp ona göre WHERE sube_id = x yapıcaz

-- PRIMARY KEY ON UPDATE CASCADE ORNEĞİ AMA RAPORDA OLMAYAN *************************

-- ALTER TABLE muster_urun_puan
-- DROP CONSTRAINT musteri_urun_puan_musteri_id_fkey;

-- ALTER TABLE musteri_urun_puan
-- ADD CONSTRAINT musteri_urun_puan_musteri_id_fkey
-- FOREIGN KEY (musteri_id)
-- REFERENCES musteri(musteri_id)
-- ON UPDATE CASCADE;

-- INSERT INTO musteri(isim,soyisim,iletisim)
-- VALUES
-- ('muhammed','soner','01020304021');

-- INSERT INTO musteri_urun_puan(musteri_id,urun_id,puan)
-- VALUES
-- (21,1,2);

-- UPDATE musteri
-- SET musteri_id = 99 WHERE musteri_id = 21;

-- *************************

-- ******************************************************************************************************************************************************

-- INSERT INTO musteri(isim,soyisim,iletisim)
-- VALUES
-- ('deneme1','denemee','01020304099');

-- INSERT INTO order_detail(order_id,urun_id)
-- VALUES
-- (24,22);

-- INSERT INTO order_detail(order_id,urun_id)
-- VALUES
-- (24,12);

-- INSERT INTO orders(musteri_id,sube_id)
-- VALUES
-- (19,4);

-- DELETE FROM orders
-- WHERE order_id =26;

-- ******************************************************************************************************************************************************

-- HAFTA 13 TRIGGER ORNEGI

-- 1) TRIGGER FONKSIYONU YAZILIR
-- STOĞU AZALT FONKSİYONU

-- CREATE OR REPLACE FUNCTION trigger_stok_dus()
-- RETURNS TRIGGER
-- LANGUAGE plpgsql
-- AS $$
-- DECLARE
-- 	bulunan_sube_id INT;
-- 	mevcut_stok INT;
-- BEGIN
-- 	-- 1) Siparişin hangi şubeden yapıldığını bulma
-- 	SELECT sube_id
-- 	INTO bulunan_sube_id
-- 	FROM orders
-- 	WHERE order_id = NEW.order_id;
-- 	-- 2) Eğer bulunan_sube_id null ise, 
-- 	-- girilen order_id ile eşleşen bir sipariş kaydı bulunamamıştır.
-- 	IF bulunan_sube_id IS NULL THEN
-- 		RAISE EXCEPTION '% numaralı sipariş yok', NEW.order_id;
-- 	END IF;
-- 	-- 3) Bulunan sube_id sayesinde o şubede sipariş edilecek olan ürün var mı kontrolü
-- 	SELECT sube_stok
-- 	INTO mevcut_stok
-- 	FROM urun_sube_stok
-- 	WHERE sube_id = bulunan_sube_id AND urun_id = NEW.urun_id;
-- 	-- 4) Eğer mevcut_stok null ise, o şubede, o ürüne ait bir kayıt açılmamıştır
-- 	IF mevcut_stok IS NULL THEN
-- 		RAISE EXCEPTION '% numaralı şubede % numaralı ürün yok', 
-- 		bulunan_sube_id , NEW.urun_id;
-- 	END IF;
-- 	-- 5) Stok yeterlilik kontrolü
-- 	IF mevcut_stok < NEW.adet THEN
-- 		RAISE EXCEPTION 'Stok yetersiz % mevcut , % istenen' , mevcut_stok , NEW.adet;
-- 	END IF;
-- 	-- 6) EĞER STOK VARSA DÜŞÜRME İŞLEMİ
-- 	UPDATE urun_sube_stok
-- 	SET sube_stok = sube_stok - NEW.adet
-- 	WHERE sube_id = bulunan_sube_id AND urun_id = NEW.urun_id;
	
-- 	RETURN NEW;
-- END;
-- $$;

-- 2) TRIGGER OLUŞTURMA 

-- order_detail TABLOSUNA VERİ EKLENİNCE FONKSİYON ÇALIŞACAK

-- CREATE TRIGGER insert_to_order_detail
-- AFTER INSERT ON order_detail
-- FOR EACH ROW
-- EXECUTE FUNCTION trigger_stok_dus();

-- INSERT INTO orders(musteri_id,sube_id,toplam_tutar)
-- VALUES
-- (20,2,249.99);

-- 20 numaralı müşteri 2 numaralı şubeden 1 tane 5li çorap aldı (urun_id 22) 

-- INSERT INTO order_detail(order_id,urun_id,birim_fiyat,adet,indirim_orani)
-- VALUES
-- (27,22,249.99,1,0.0);

-- INSERT INTO orders(musteri_id , sube_id , toplam_tutar)
-- VALUES
-- (20,2,250);

-- INSERT INTO orders(musteri_id , sube_id , toplam_tutar)
-- VALUES
-- (20,2,1000); -- 20 NUMARALI MÜŞTERİ 2 NUMARALI ŞUBEDEN 1000 TL LİK ALIŞVERİŞ YAPMIŞ

-- INSERT INTO order_detail(order_id,urun_id,adet)
-- VALUES
-- (28,10,248); -- YETERSİZ STOK SORGUSU

-- INSERT INTO order_detail(order_id,urun_id,adet)
-- VALUES
-- (29,12,27); -- ÖRNEK SORGU 29 NUMARALI SİPARİŞİN İÇERİĞİ 12 NUMARALI ÜRÜNDEN 27 ADET


-- ****************************************************************************************************


-- HAFTA 14
-- VIEW ORNEGI
 
-- stok sayısı 25 ten düşük olan ürünlerin bilgilerini getireceğiz

-- CREATE OR REPLACE VIEW kritik_stok_kontrol AS

-- SELECT sube.sube_id AS "Şube ID" ,
-- sube.sube_ismi AS "Şube İsmi" ,
-- urun.urun_id AS "Ürün ID" ,
-- urun.urun_ismi AS "Ürün İsmi" ,
-- urun_sube_stok.sube_stok AS "Adet"

-- FROM urun_sube_stok
-- JOIN urun ON urun.urun_id = urun_sube_stok.urun_id
-- JOIN sube ON sube.sube_id = urun_sube_stok.sube_id
-- WHERE urun_sube_stok.sube_stok <= 25
-- ORDER BY urun_sube_stok.sube_id;


SELECT * FROM kritik_stok_kontrol;









