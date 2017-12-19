-- TRANSKRIP SISWA --

--PROFIL SISWA--
SELECT NO_SISWA as "ID", S_NAMA as "Nama", S_ALAMAT as "Alamat", S_TELP as "Telpon"
FROM SISWA
WHERE NO_SISWA = 'S0002';

--KURSUS YANG SEDANG DIAMBIL;;
SELECT pk.pk_tglmulai as "Tgl. Mulai", cbg.cbg_lokasi as "Cabang Kursus", lv.lv_nama as "Level", p.p_nama as "Pengajar", pk.pk_nama as "Nama Kursus"
FROM pengajar p, paket_kursus pk, cabang cbg, level_table lv, siswa s, detil_kursus dk
WHERE s.NO_SISWA = dk.NO_SISWA
AND pk.pk_id = dk.pk_id
AND lv.lv_id = pk.lv_id
AND cbg.cbg_id = pk.cbg_id
AND p.pengajar_id = pk.pengajar_id
AND s.NO_SISWA = 'S0002'
AND dk.status_tes IS NULL;

-- RIWAYAT KURSUS --
SELECT pk.pk_tglselesai as "Tgl. Selesai", cbg.cbg_lokasi as "Cabang Kursus", lv.lv_nama as "Level", pk.pk_nama as "Nama Kursus", dk.nilai as "Nilai", dk.status_tes as "Status"
FROM pengajar p, paket_kursus pk, cabang cbg, level_table lv, siswa s, detil_kursus dk
WHERE s.NO_SISWA = dk.NO_SISWA
AND pk.pk_id = dk.pk_id
AND lv.lv_id = pk.lv_id
AND cbg.cbg_id = pk.cbg_id
AND p.pengajar_id = pk.pengajar_id
AND s.NO_SISWA = 'S0002'
AND dk.status_tes IS NOT NULL;




-- LAPORAN --

-- RATA RATA PROSENTASE SISWA LULUS PER LEVEL CAB. KERTAJAYA --
SELECT lv.lv_nama, AVG(dk.nilai) AS Ratanilai
FROM pengajar p, paket_kursus pk, cabang cbg, level_table lv, siswa s, detil_kursus dk
WHERE s.NO_SISWA = dk.NO_SISWA
AND pk.pk_id = dk.pk_id
AND lv.lv_id = pk.lv_id
AND cbg.cbg_id = pk.cbg_id
AND p.pengajar_id = pk.pengajar_id
AND cbg.cbg_id = 'CB001'
AND dk.status_tes = 'LULUS'
GROUP BY lv.lv_nama;

-- LIMA PAKET KURSUS TERPOPULER 2017 (SEMUA CABANG) --
SELECT * FROM ( SELECT pk.pk_nama as "Nama Paket", count(pk.pk_nama) as "Jml. Peserta" 
FROM pengajar p, paket_kursus pk, cabang cbg, level_table lv, siswa s, detil_kursus dk
WHERE s.NO_SISWA = dk.NO_SISWA
AND pk.pk_id = dk.pk_id
AND lv.lv_id = pk.lv_id
AND cbg.cbg_id = pk.cbg_id
AND p.pengajar_id = pk.pengajar_id
GROUP BY pk.pk_nama
ORDER BY count(pk.pk_nama) DESC
)
WHERE ROWNUM <= 5;

-- PENGHARGAAN UNTUK PENGAJAR TERBAIK 2017 DI CABANG MANYAR --
SELECT p.p_nama as "Pengajar", pk.pk_nama as "Nama Kursus", avg(dk.nilai) as "Rata-rata Nilai Kelas", pk.pk_tglmulai as "Tgl Mulai Kursus", pk.pk_tglselesai as "Tgl Selesai Kursus"
FROM pengajar p, paket_kursus pk, cabang cbg, level_table lv, siswa s, detil_kursus dk
WHERE s.NO_SISWA = dk.NO_SISWA
AND pk.pk_id = dk.pk_id
AND lv.lv_id = pk.lv_id
AND cbg.cbg_id = pk.cbg_id
AND p.pengajar_id = pk.pengajar_id
AND cbg.cbg_id = 'CB002'
GROUP BY p.p_nama, pk.pk_nama, pk.pk_tglmulai, pk.pk_tglselesai
ORDER BY avg(dk.nilai) DESC;