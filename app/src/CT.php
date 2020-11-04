<?php

class CT { 

    public function clearing(){
        $Prov = DataObject::get('ProvinsiData', 'ID <= 22 AND ID >= 21');
        foreach($Prov as $p){
            $kab = $p->KabupatenData();
            foreach($kab as $k){
                $kec = $k->KecamatanData();
                foreach($kec as $kec){
                    $kec->delete();
                }
                $k->delete();
            }
            $p->delete();
        }
        die();
    }

    public function updatelokasi(){
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_URL, "https://dev.farizdotid.com/api/daerahindonesia/provinsi");
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);  // penting, karena SSL
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 2);      // penting, karena SSL
        $result = curl_exec($curl);
        curl_close($curl);
        $resultProv = json_decode($result, true);
        $resultProv = array_slice($resultProv['provinsi'], 32, 2); 
        foreach ($resultProv as $p) {
            $newProp = new ProvinsiData();
            $newProp->Title = $p['nama'];
            $newProp->write();
            $curl = curl_init();
            curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($curl, CURLOPT_URL, "https://dev.farizdotid.com/api/daerahindonesia/kota?id_provinsi=".$p['id']);
            curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);  // penting, karena SSL
            curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 2);      // penting, karena SSL
            $result = curl_exec($curl);
            curl_close($curl);
            $result = json_decode($result, true);
            foreach ($result['kota_kabupaten'] as $kab) {
                $newKab = new KabupatenData();
                $newKab->ProvinsiDataID =$newProp->ID;
                $newKab->Title = $kab['nama'];
                $newKab->write();
                //get kecamatan
                $curl = curl_init();
                curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
                curl_setopt($curl, CURLOPT_URL, "https://dev.farizdotid.com/api/daerahindonesia/kecamatan?id_kota=".$kab['id']);
                curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);  // penting, karena SSL
                curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 2);      // penting, karena SSL
                $resultKec = curl_exec($curl);
                curl_close($curl);
                $resultKec = json_decode($resultKec, true);
                foreach ($resultKec['kecamatan'] as $kc) {
                    $newKec = new KecamatanData();
                    $newKec->Title = $kc['nama'];
                    $newKec->KabupatenDataID = $newKab->ID;
                    $newKec->write();
                }
            }
        }
        die("Done");
    }
}