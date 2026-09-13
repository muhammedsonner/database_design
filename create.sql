
------------------------------------------------

-- 1. KATEGORİ TABLOSU
CREATE TABLE "kategori" (
    kategori_id serial primary key,
    kategori_ismi varchar(50) NOT NULL
);

-- 2. ŞUBE TABLOSU
CREATE TABLE "sube"(
    sube_id serial primary key,
    sube_ismi varchar(50) NOT NULL,
    sehir varchar(25),
    adres text
);

-- 3. DEPARTMAN TABLOSU
CREATE TABLE "departman"(
    departman_id serial primary key,
    departman_ismi varchar(50) NOT NULL
);


-- 4. TEDARİKÇİ TABLOSU
CREATE TABLE "tedarikci"(
    supplier_id serial primary key,
    firma_ismi varchar(50) NOT NULL,
    sehir varchar(25),
    adres text
);


-- 5. DEPO TABLOSU
CREATE TABLE "depo"(
    depo_id serial primary key,
    depo_ismi varchar(50) NOT NULL,
    adres text
);


-- 6. MÜŞTERİ TABLOSU 
CREATE TABLE "musteri" (
    musteri_id serial primary key,
    isim varchar(25) NOT NULL,
    soyisim varchar(25) NOT NULL,
    iletisim varchar(15) unique
);


-- 7. PERSONEL TABLOSU 
CREATE TABLE "personel"(
    personel_id serial primary key,
    isim varchar(25) NOT NULL,
    soyisim varchar(25) NOT NULL,
    iletisim varchar(15) unique,
	   departman_id int references departman(departman_id),
    maas int check (maas > 22004)
);


-- 8. ÜRÜN TABLOSU
CREATE TABLE "urun" (
    urun_id serial primary key,
    kategori_id int references kategori(kategori_id),
    urun_ismi varchar(50) NOT NULL,
    fiyat real not null
);


-- 9. SİPARİŞ TABLOSU 
CREATE TABLE "orders"(
    order_id serial primary key,
    musteri_id int references musteri(musteri_id),
    sube_id int references sube(sube_id),
    tarih date default CURRENT_DATE,
    toplam_tutar real
);


--- İLİŞKİ VE İŞLEM TABLOLARI ---


-- 10. SİPARİŞ DETAYLARI
CREATE TABLE "order_detail"(
    order_id int references orders(order_id),
    urun_id int references urun(urun_id),
    birim_fiyat real,
    adet int,
    indirim_orani real,
    primary key(order_id , urun_id)
);


-- 11. ŞUBE STOK (Bulunur İlişkisi)
CREATE TABLE "urun_sube_stok"(
    sube_id int references sube(sube_id),
    urun_id int references urun(urun_id),
    sube_stok int default 0,
    primary key(sube_id, urun_id)
);


-- 12. DEPO STOK (saklanır)
CREATE TABLE "depo_stok"(
    depo_id int references depo(depo_id),
    urun_id int references urun(urun_id),
    adet int default 0,
    primary key(depo_id, urun_id)
);


-- 13. TEDARİKÇİDEN DEPOYA SEVKİYAT (Temin Eder)
CREATE TABLE "tedarik_islem"(
    islem_id serial primary key,
    supplier_id int references tedarikci(supplier_id),
    depo_id int references depo(depo_id),
    urun_id int references urun(urun_id),
    adet int,
    sevkiyat_tarihi date
);


-- 14. DEPODAN ŞUBEYE SEVKİYAT (Stok Sağlar)
CREATE TABLE "depo_sevk_islem"(
    sevk_id serial primary key,
    depo_id int references depo(depo_id),
    sube_id int references sube(sube_id),
    urun_id int references urun(urun_id),
    adet int,
    sevkiyat_tarihi date
);


-- 15. İADE TABLOSU (iade)
CREATE TABLE "iade"(
    iade_id serial primary key,
    musteri_id int references musteri(musteri_id),
    order_id int references orders(order_id),
    urun_id int references urun(urun_id),
    iade_tarihi date default CURRENT_DATE
);



-- 16. PUAN
CREATE TABLE "musteri_urun_puan"(
    rate_id serial primary key,
    musteri_id int references musteri(musteri_id),
    urun_id int references urun(urun_id),
    puan int check (puan between 1 and 5)
);


-- 17. PERSONEL ŞUBE GEÇMİŞİ (Çalışır)
CREATE TABLE "personel_sube_gecmis"(
    kayit_id serial primary key,
    personel_id int references personel(personel_id),
    sube_id int references sube(sube_id),
    giris_tarihi date,
    cikis_tarihi date
);


