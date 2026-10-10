-- ON DELETE CASCADE ÖRNEĞİ

-- ÖNCE order_detail tablosundaki order_id 
-- foreign key kısıtlamasını kaldırıyoruz

ALTER TABLE order_detail
DROP CONSTRAINT IF EXISTS order_detail_order_id_fkey;


-- SONRA order_detail tablosuna order_id foreign key kısıtlamasını 
-- ON DELETE CASCADE olacak şekilde tekrar ekliyoruz

ALTER TABLE order_detail
ADD CONSTRAINT order_detail_order_id_fkey
FOREIGN KEY (order_id)
REFERENCES orders(order_id)
ON DELETE CASCADE;

-- ORDERS TABLOSUNDAKİ ORDER_ID Sİ ÖRNEK OLARAK 3 OLAN SİPARİŞ SİLİNİNCE ORDER_DETAIL TABLOSUNDA ORDER_ID Sİ 3 OLANLAR SİLİNECEKTİR

-- **************************************************

-- ÖNCE orders tablosundaki sube_id 
--foreign key kısıtlamasını kaldırıyoruz

ALTER TABLE orders
DROP CONSTRAINT IF EXISTS orders_sube_id_fkey;

-- SONRA orders tablosuna sube_id foreign key kısıtlamasını 
--ON DELETE SET NULL olacak şekilde tekrar ekliyoruz

ALTER TABLE orders
ADD CONSTRAINT orders_sube_id_fkey
FOREIGN KEY (sube_id)
REFERENCES sube(sube_id)
ON DELETE SET NULL;

-- SUBE TABLOSUNDA SUBE_ID Sİ 1 OLAN SATIR SİLİNİNCE ORDERS TABLOSUNDA SUBE_ID Sİ 1 OLAN SATIRLARI NULL YAPACAK

-- **************************************************

-- hangi şubeden kaç alışveriş yapıldığını sayan fonksiyon

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

-- *************************

-- ******************************************************************************************************************************************************

-- TRIGGER ORNEGI

-- 1) TRIGGER FONKSIYONU YAZILIR
-- STOĞU AZALT FONKSİYONU

CREATE OR REPLACE FUNCTION trigger_stok_dus()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
	bulunan_sube_id INT;
	mevcut_stok INT;
BEGIN
	-- 1) Siparişin hangi şubeden yapıldığını bulma
	SELECT sube_id
	INTO bulunan_sube_id
	FROM orders
	WHERE order_id = NEW.order_id;
	-- 2) Eğer bulunan_sube_id null ise, 
	-- girilen order_id ile eşleşen bir sipariş kaydı bulunamamıştır.
	IF bulunan_sube_id IS NULL THEN
		RAISE EXCEPTION '% numaralı sipariş yok', NEW.order_id;
	END IF;
	-- 3) Bulunan sube_id sayesinde o şubede sipariş edilecek olan ürün var mı kontrolü
	SELECT sube_stok
	INTO mevcut_stok
	FROM urun_sube_stok
	WHERE sube_id = bulunan_sube_id AND urun_id = NEW.urun_id;
	-- 4) Eğer mevcut_stok null ise, o şubede, o ürüne ait bir kayıt açılmamıştır
	IF mevcut_stok IS NULL THEN
		RAISE EXCEPTION '% numaralı şubede % numaralı ürün yok', 
		bulunan_sube_id , NEW.urun_id;
	END IF;
	-- 5) Stok yeterlilik kontrolü
	IF mevcut_stok < NEW.adet THEN
		RAISE EXCEPTION 'Stok yetersiz % mevcut , % istenen' , mevcut_stok , NEW.adet;
	END IF;
	-- 6) EĞER STOK VARSA DÜŞÜRME İŞLEMİ
	UPDATE urun_sube_stok
	SET sube_stok = sube_stok - NEW.adet
	WHERE sube_id = bulunan_sube_id AND urun_id = NEW.urun_id;
	
	RETURN NEW;
END;
$$;

-- 2) TRIGGER OLUŞTURMA 

-- order_detail TABLOSUNA VERİ EKLENİNCE FONKSİYON ÇALIŞACAK

CREATE TRIGGER insert_to_order_detail
AFTER INSERT ON order_detail
FOR EACH ROW
EXECUTE FUNCTION trigger_stok_dus();

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

-- VIEW ORNEGI
 
-- stok sayısı 25 ten düşük olan ürünlerin bilgilerini getireceğiz

CREATE OR REPLACE VIEW kritik_stok_kontrol AS (
	SELECT 
		sube.sube_id AS "Şube ID" ,
		sube.sube_ismi AS "Şube İsmi" ,
		urun.urun_id AS "Ürün ID" ,
		urun.urun_ismi AS "Ürün İsmi" ,
		urun_sube_stok.sube_stok AS "Adet"
	FROM urun_sube_stok
	JOIN urun ON urun.urun_id = urun_sube_stok.urun_id
	JOIN sube ON sube.sube_id = urun_sube_stok.sube_id
	WHERE urun_sube_stok.sube_stok <= 25
	ORDER BY urun_sube_stok.sube_id	
);


SELECT * FROM kritik_stok_kontrol;









