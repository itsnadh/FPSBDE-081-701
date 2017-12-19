CREATE TABLE siswa(
 no_siswa	CHAR(5) NOT NULL PRIMARY KEY,
 s_nama		VARCHAR(150),
 s_alamat 	VARCHAR(150),
 s_noktp	VARCHAR(20),
 s_telp		VARCHAR(15),
 s_email	VARCHAR(100),
 s_tgldaftar	DATE
);

CREATE TABLE pengajar(
 pengajar_id char(5) NOT NULL PRIMARY KEY,
 p_nama		VARCHAR(100),
 p_alamat	VARCHAR(150),
 p_telp		VARCHAR(15),
 p_email	VARCHAR(50)
);

CREATE TABLE level_table(
 lv_id		CHAR(5) NOT NULL PRIMARY KEY,
 lv_nama	VARCHAR(100),
 lv_deskripsi	VARCHAR(300)
);

CREATE TABLE CABANG(
 cbg_id 	CHAR(5) NOT NULL PRIMARY KEY,
 cbg_lokasi VARCHAR(50),
 cbg_telp VARCHAR(50)
);

CREATE TABLE paket_kursus(
 pk_id		CHAR(5) NOT NULL PRIMARY KEY,
 cbg_id		CHAR(5) NOT NULL,
 lv_id		CHAR(5) NOT NULL,
 pengajar_id	CHAR(5) NOT NULL,
 pk_nama	VARCHAR(100),
 pk_deskripsi VARCHAR(300),
 pk_tarif	INTEGER,
 pk_tglmulai	DATE,
 pk_tglselesai	DATE,
);

CREATE TABLE detil_kursus(
 pk_id		CHAR(5) NOT NULL,
 no_siswa	CHAR(5) NOT NULL,
 status_tes	VARCHAR(10),
 nilai		integer
);

-- Creating Relations --

ALTER TABLE paket_kursus
ADD CONSTRAINT fk_pk_pg FOREIGN KEY (pengajar_id) REFERENCES pengajar(pengajar_id);
ALTER TABLE paket_kursus
ADD CONSTRAINT fk_lv_id FOREIGN KEY (lv_id) REFERENCES level_table(lv_id);
ALTER TABLE paket_kursus
ADD CONSTRAINT fk_cbg_id FOREIGN KEY (cbg_id) REFERENCES CABANG(cbg_id);
ALTER TABLE detil_kursus
ADD CONSTRAINT fk_dk_pk FOREIGN KEY (pk_id)	REFERENCES paket_kursus(pk_id);
ALTER TABLE detil_kursus
ADD CONSTRAINT fk_dk_s  FOREIGN KEY (no_siswa)	REFERENCES siswa(no_siswa);
